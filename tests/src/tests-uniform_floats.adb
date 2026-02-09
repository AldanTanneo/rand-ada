with Rand.Distributions;
use Rand;

procedure Tests.Uniform_Floats is
   R : Rng := Thread_Rng;

   X  : Float;
   subtype U1 is Distributions.Interfaces.Float_Distr.Distribution'Class;
   D1 : constant U1 := Distributions.Uniform_Float.Create (50.0, 2500.0);
   D2 : constant U1 := Distributions.Uniform_Float.Create (-1000.0, 1000.0);

   Y  : Long_Float;
   subtype U2 is Distributions.Interfaces.Long_Float_Distr.Distribution'Class;
   D3 : constant U2 :=
     Distributions.Uniform_Long_Float.Create
       (Long_Float'First / 2.0, Long_Float'Last / 2.0);
begin
   for I in 1 .. 1000000 loop
      X := D1.Sample (R);
      Assert (50.0 <= X and then X < 2500.0, "float not in required range");

      X := D2.Sample (R);
      Assert (-1000.0 <= X and then X < 1000.0, "float not in required range");

      Y := D3.Sample (R);
      Assert (Y'Valid, "invalid Long_Float");
   end loop;
end Tests.Uniform_Floats;
