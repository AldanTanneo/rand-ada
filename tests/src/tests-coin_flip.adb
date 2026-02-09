with Rand.Distributions;
use Rand;

procedure Tests.Coin_Flip is
   R1 : Rng := Thread_Rng;
   R2 : Rng := Small_Rng;

   P       : constant := 0.3;
   N       : constant := 100000;
   Epsilon : constant := 5.0e-3;

   Sum1, Sum2 : Natural := 0;
   Avg1, Avg2 : Long_Float;

   D : constant Distributions.Bernoulli.Distribution :=
     Distributions.Bernoulli.Create (P);
begin
   for I in 1 .. N loop
      if D.Sample (R1) then
         Sum1 := Sum1 + 1;
      end if;

      if D.Sample (R2) then
         Sum2 := Sum2 + 1;
      end if;
   end loop;

   Avg1 := Long_Float (Sum1) / Long_Float (N);
   Avg2 := Long_Float (Sum2) / Long_Float (N);

   Assert
     (Avg1 - P in -Epsilon .. Epsilon,
      "average #1 too far from P: " & Avg1'Img);
   Assert
     (Avg2 - P in -Epsilon .. Epsilon,
      "average #2 too far from P: " & Avg2'Img);
end Tests.Coin_Flip;
