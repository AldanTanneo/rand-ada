with Rand_Core.Utils;
with Ada.Unchecked_Conversion;

package body Rand_Distributions.Uniform is

   package body Floating_Point is

      pragma
        Compile_Time_Error
          (T'Machine_Mantissa > 64,
           "float mantissa is too large (max 64 bits)");
      --  supports x86 extended precision (64 bits mantissa)
      pragma
        Compile_Time_Error (T'Machine_Radix /= 2, "machine radix is not 2");

      Bits_To_Discard : constant Natural := 64 - B'Machine_Mantissa;
      Msb_Mask        : constant U64 := Utils.Shl (1, B'Machine_Mantissa - 1);
      Max_Rand        : constant B := B'Adjacent (1.0, 0.0);

      function Create (Low : T := 0.0; High : T := 1.0) return Distribution is
         pragma Assert (Low'Valid, "invalid low bound for distribution");
         pragma Assert (High'Valid, "invalid high bound for distribution");
         pragma Assert (Low < High, "uniform distribution with empty range");
         Scale : B := High - Low;
         pragma Assert (Scale'Valid, "invalid scale in distribution");
      begin
         while (Max_Rand * Scale + B (Low)) >= B (High) loop
            --  reduce the scale to prevent range overflow caused by precision
            --  errors. `Scale` cannot go below 0.0.
            Scale := B'Adjacent (Scale, 0.0);
         end loop;

         return (Offset => Low, Scale => Scale);
      end Create;

      function Sample_Generic (D : Distribution; R : in out Rng) return T is
         use all type U64;
         Mantissa : constant U64 :=
           Utils.Shr (R.Next, Bits_To_Discard) or Msb_Mask;
         --  shift out the non significant bits + 1, and add a `1` MSB to get
         --  a mantissa that is always the same size

         Value_1_2 : constant B := B'Compose (B (Mantissa), 1);
         --  set the exponent to 1 in the canonical representation, getting a
         --  value uniformly sampled from [1, 2)
         Value_0_1 : constant B := Value_1_2 - 1.0;
         --  substract 1 to get a value in [0, 1)
      begin
         return T (Value_0_1 * D.Scale + D.Offset);
      end Sample_Generic;

      function Sample_Impl is new Sample_Generic (Generators.Rng'Class);
      pragma Inline_Always (Sample_Impl);

      overriding
      function Sample
        (D : Distribution; R : in out Generators.Rng'Class) return T
      is (Sample_Impl (D, R));

   end Floating_Point;

   package body Discrete is
      use all type U32;
      use all type U64;
      use all type U128;

      Mask_32 : constant U64 := 2**32 - 1;

      function Sample_Generic (D : Distribution; R : in out Rng) return T is
      begin
         if B'Size > 64 then
            declare
               function Gen (R : in out Rng) return U128
               is (Utils.Shl (U128 (R.Next), 64) or U128 (R.Next))
               with Inline_Always;

               pragma Warnings ("Z");
               function Conv_To_Unsigned is new
                 Ada.Unchecked_Conversion (B, U128);
               function Conv_To_Result is new
                 Ada.Unchecked_Conversion (U128, B);
               pragma Warnings ("z");

               Hi, Lo : U128;
            begin
               if D.Span = 0 then
                  return Conv_To_Result (Gen (R) + Conv_To_Unsigned (D.Low));
               else
                  loop
                     Utils.Wide_Mul (Gen (R), D.Span, Hi, Lo);
                     exit when Lo >= D.Thresh;
                  end loop;

                  return Conv_To_Result (Hi + Conv_To_Unsigned (D.Low));
               end if;
            end;
         elsif B'Size > 32 then
            declare
               pragma Warnings ("Z");
               function Conv_To_Unsigned is new
                 Ada.Unchecked_Conversion (B, U64);
               function Conv_To_Result is new
                 Ada.Unchecked_Conversion (U64, B);
               pragma Warnings ("z");

               Hi, Lo : U64;
            begin
               if D.Span = 2**64 then
                  return Conv_To_Result (R.Next + Conv_To_Unsigned (D.Low));
               else
                  loop
                     Utils.Wide_Mul (R.Next, U64 (D.Span), Hi, Lo);
                     exit when Lo >= U64 (D.Thresh);
                  end loop;

                  return Conv_To_Result (Hi + Conv_To_Unsigned (D.Low));
               end if;
            end;
         elsif D.Span = 2**32 then
            return T'Val (T'Pos (D.Low) + U32'Pos (U32 (R.Next and Mask_32)));
         else
            declare
               Hi, Lo : U32;
            begin
               loop
                  Utils.Wide_Mul
                    (U32 (R.Next and Mask_32), U32 (D.Span), Hi, Lo);
                  exit when Lo >= U32 (D.Thresh);
               end loop;

               return T'Val (T'Pos (D.Low) + U32'Pos (Hi));
            end;
         end if;
      end Sample_Generic;

      function Sample_Impl is new Sample_Generic (Generators.Rng'Class);
      pragma Inline_Always (Sample_Impl);

      function Sample
        (D : Distribution; R : in out Generators.Rng'Class) return T
      is (Sample_Impl (D, R));

      function Create
        (Low : T := T'First; High : T := T'Last) return Distribution
      is
         pragma Assert (Low <= High, "uniform distribution with empty range");

         pragma Suppress (Overflow_Check);
         -- safe even when position cannot be represented in U128;
         -- unsigned substraction is equivalent to signed
         Span   : constant U128 := B'Pos (High) - B'Pos (Low) + 1;
         pragma Unsuppress (Overflow_Check);
         Thresh : constant U128 := (if Span > 0 then (-Span) mod Span else 0);
      begin
         return (Low, Span, Thresh);
      end Create;

   end Discrete;

end Rand_Distributions.Uniform;
