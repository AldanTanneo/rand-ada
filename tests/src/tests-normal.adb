with Ada.Numerics;
with Ada.Numerics.Long_Elementary_Functions;
with Rand; use Rand;

procedure Tests.Normal is
   R : Rng := Thread_Rng;

   Mean    : constant := 7.0;
   Stddev  : constant := 3.0;
   Epsilon : constant := 1.0e-2;
   N       : constant := 1000000;

   D : constant Distributions.Normal_Long_Float.Distribution :=
     Distributions.Normal_Long_Float.Create (Mean, Stddev);

   X, S1, S2 : Long_Float := 0.0;
begin
   for I in 1 .. N loop
      X := D.Sample (R);
      --  remove mean to prevent error accumulation;
      --  Mean (X - K) = Mean (X) - K
      --  Var (X - K) = Var (X)
      S1 := S1 + (X - Mean);
      S2 := S2 + (X - Mean) ** 2;
   end loop;

   S1 := S1 / Long_Float (N);
   S2 :=
     Ada.Numerics.Long_Elementary_Functions.Sqrt
       (S2 / Long_Float (N) - S1 ** 2);

   Assert
     (abs S1 < Epsilon,
      "mean too far from wanted value:" & Long_Float'(S1 + Mean)'Img);
   Assert
     (abs (S2 - Stddev) < Epsilon,
      "stddev too far from wanted value:" & S2'Img);
end Tests.Normal;
