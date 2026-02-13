with Ada.Numerics.Long_Elementary_Functions;

with Rand; use Rand;

procedure Tests.Uniform_Floats is
   N       : constant := 10000000;
   Epsilon : constant := 1.0;

   R : Rng := Thread_Rng;

   X, M1, M2, V1, V2 : Long_Float := 0.0;

   subtype D is Distributions.Interfaces.Long_Float_Distr.Distribution'Class;
   D1 : constant D := Distributions.Uniform_Long_Float.Create (50.0, 2500.0);
   D2 : constant D :=
     Distributions.Uniform_Long_Float.Create (-1000.0, 1000.0);

   Mean1 : constant Long_Float := (2500.0 + 50.0) / 2.0;
   Var1  : constant Long_Float :=
     Ada.Numerics.Long_Elementary_Functions.Sqrt ((2500.0 - 50.0) ** 2 / 12.0);
   Mean2 : constant Long_Float := 0.0;
   Var2  : constant Long_Float :=
     Ada.Numerics.Long_Elementary_Functions.Sqrt (2000.0 ** 2 / 12.0);

   Y  : Long_Float;
   D3 : constant D :=
     Distributions.Uniform_Long_Float.Create
       (Long_Float'First / 2.0, Long_Float'Last / 2.0);
begin
   for I in 1 .. N loop
      X := D1.Sample (R);
      Assert (50.0 <= X and then X < 2500.0, "float not in required range");
      M1 := M1 + (X - Mean1);
      V1 := V1 + (X - Mean1) ** 2;

      X := D2.Sample (R);
      Assert (-1000.0 <= X and then X < 1000.0, "float not in required range");
      M2 := M2 + (X - Mean2);
      V2 := V2 + (X - Mean2) ** 2;

      Y := D3.Sample (R);
      Assert (Y'Valid, "invalid Long_Float");
   end loop;

   M1 := M1 / Long_Float (N);
   V1 :=
     Ada.Numerics.Long_Elementary_Functions.Sqrt
       (V1 / Long_Float (N) - M1 ** 2);

   Assert
     (abs M1 < Epsilon,
      "mean #1 too far from wanted value:"
      & Long_Float'(M1 + Mean1)'Image
      & ", expected"
      & Mean1'Image);
   Assert
     (abs (V1 - Var1) < Epsilon,
      "variance #1 too far from wanted value:"
      & V1'Image
      & ", expected"
      & Var1'Image);

   M2 := M2 / Long_Float (N);
   V2 :=
     Ada.Numerics.Long_Elementary_Functions.Sqrt
       (V2 / Long_Float (N) - M2 ** 2);

   Assert
     (abs M2 < Epsilon,
      "mean #2 too far from wanted value:"
      & Long_Float'(M2 + Mean2)'Image
      & ", expected"
      & Mean2'Image);
   Assert
     (abs (V2 - Var2) < Epsilon,
      "variance #2 too far from wanted value:"
      & V2'Image
      & ", expected"
      & Var2'Image);
end Tests.Uniform_Floats;
