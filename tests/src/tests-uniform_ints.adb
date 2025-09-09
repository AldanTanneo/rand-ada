with Rand.Distributions;
use Rand;

procedure Tests.Uniform_Ints is
   use Core;

   R : Rng'Class := Thread_Rng;

   X  : Integer;
   subtype U1 is Distributions.Interfaces.Int_Distr.Distribution'Class;
   D1 : constant U1 := Distributions.Uniform_Int.Create (50, 2500);
   D2 : constant U1 := Distributions.Uniform_Int.Create (-1000, 1000);

   Y  : I128;
   subtype U2 is Distributions.Interfaces.I128_Distr.Distribution'Class;
   D3 : constant U2 :=
     Distributions.Uniform_I128.Create (I128'First, I128'Last);
begin
   for I in 1 .. 10000 loop
      X := D1.Sample (R);
      Assert (50 <= X and then X <= 2500);

      X := D2.Sample (R);
      Assert (-1000 <= X and then X <= 1000);

      Y := D3.Sample (R);
      Assert (Y'Valid);
   end loop;
end Tests.Uniform_Ints;
