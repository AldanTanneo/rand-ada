with Rand; use Rand;
with Rand_Distributions.Uniform;

procedure Tests.Uniform_Enum is
   N       : constant := 1000000;
   Epsilon : constant := 1500;

   type T is (A, B, C, D, E, F);

   package T_Distr is new Rand_Distributions.Generic_Distribution (T);
   package T_Uniform is new Rand_Distributions.Uniform.Discrete (T, T_Distr);

   R  : Rng := Thread_Rng;
   U1 : constant T_Uniform.Distribution := T_Uniform.Create;
   U2 : constant T_Uniform.Distribution := T_Uniform.Create (B, E);

   X      : T;
   C1, C2 : array (T) of Long_Integer := [others => 0];

   Est1 : constant Long_Integer := N / 6;
   Est2 : constant Long_Integer := N / 4;
begin
   for I in 1 .. N loop
      X := U1.Sample (R);
      Assert (X'Valid, "invalid enum member");
      C1 (X) := C1 (X) + 1;

      X := U2.Sample (R);
      Assert (X in B .. E, "enum member not in required range");
      C2 (X) := C2 (X) + 1;
   end loop;

   Assert
     ((for all I in A .. F => abs (C1 (I) - Est1) < Epsilon),
      "counts too biased for #1: " & C1'Image & ", expected" & Est1'Image);

   Assert
     ((for all I in B .. E => abs (C2 (I) - Est2) < Epsilon),
      "counts too biased for #2: " & C2'Image & ", expected" & Est2'Image);
   Assert (C2 (A) = 0 and then C2 (F) = 0);
end Tests.Uniform_Enum;
