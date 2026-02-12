
package body Rand_Distributions.Normal
  with Pure
is

   function Sample_Generic (D : Distribution; R : in out Rng) return T is
      function Gen_T is new Generators.Generic_Float (T, Rng);
      pragma Inline_Always (Gen_T);

      X, Y, S : T;
   begin
      loop
         Y := Gen_T (R) * 2.0 - 1.0;
         X := Gen_T (R) * 2.0 - 1.0;
         S := X ** 2 + Y ** 2;
         exit when S < 1.0 and S > 0.0;
      end loop;
      S := Elementary_Functions.Sqrt (-2.0 * Elementary_Functions.Log (S) / S);
      return D.Mean + D.Stddev * Y * S;
   end Sample_Generic;

   function Sample_Impl is new Sample_Generic (Generators.Rng'Class);
   pragma Inline (Sample_Impl);

   function Sample (D : Distribution; R : in out Generators.Rng'Class) return T
   renames Sample_Impl;

end Rand_Distributions.Normal;
