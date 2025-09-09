with Rand_Distributions.Bernoulli;
with Rand_Distributions.Uniform;
use Rand_Distributions;

package Rand.Distributions is
   use Core;

   package Bool_Distr is new Generic_Distribution (Boolean);

   package Float_Distr is new Generic_Distribution (Float);
   package Long_Float_Distr is new Generic_Distribution (Long_Float);
   package Long_Long_Float_Distr is new Generic_Distribution (Long_Long_Float);

   package Int_Distr is new Generic_Distribution (Integer);
   package Long_Int_Distr is new Generic_Distribution (Long_Integer);
   package Long_Long_Int_Distr is new Generic_Distribution (Long_Long_Integer);

   package Natural_Distr is new Generic_Distribution (Natural);
   package Positive_Distr is new Generic_Distribution (Positive);

   package U8_Distr is new Generic_Distribution (U8);
   package U16_Distr is new Generic_Distribution (U16);
   package U32_Distr is new Generic_Distribution (U32);
   package U64_Distr is new Generic_Distribution (U64);
   package U128_Distr is new Generic_Distribution (U128);

   package Bernoulli is new Rand_Distributions.Bernoulli (Bool_Distr);

   package Uniform is
      package Uniform_Float is new
        Rand_Distributions.Uniform.Floating_Point (Float, Float_Distr);
      package Uniform_Long_Float is new
        Rand_Distributions.Uniform.Floating_Point
          (Long_Float,
           Long_Float_Distr);
      package Uniform_Long_Long_Float is new
        Rand_Distributions.Uniform.Floating_Point
          (Long_Long_Float,
           Long_Long_Float_Distr);

      package Uniform_Int is new
        Rand_Distributions.Uniform.Discrete (Integer, Int_Distr);
      package Uniform_Long_Int is new
        Rand_Distributions.Uniform.Discrete (Long_Integer, Long_Int_Distr);
      package Uniform_Long_Long_Int is new
        Rand_Distributions.Uniform.Discrete
          (Long_Long_Integer,
           Long_Long_Int_Distr);

      package Uniform_Nat is new
        Rand_Distributions.Uniform.Discrete (Natural, Natural_Distr);
      package Uniform_Pos is new
        Rand_Distributions.Uniform.Discrete (Positive, Positive_Distr);

      package Uniform_U8 is new
        Rand_Distributions.Uniform.Discrete (U8, U8_Distr);
      package Uniform_U16 is new
        Rand_Distributions.Uniform.Discrete (U16, U16_Distr);
      package Uniform_U32 is new
        Rand_Distributions.Uniform.Discrete (U32, U32_Distr);
      package Uniform_U64 is new
        Rand_Distributions.Uniform.Discrete (U64, U64_Distr);
      package Uniform_U128 is new
        Rand_Distributions.Uniform.Discrete (U128, U128_Distr);
   end Uniform;

end Rand.Distributions;
