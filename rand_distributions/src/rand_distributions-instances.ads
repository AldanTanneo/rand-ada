--  Instantiations of distributions for various common types

with Rand_Distributions.Bernoulli;
with Rand_Distributions.Normal;
with Rand_Distributions.Uniform;

package Rand_Distributions.Instances
  with Pure
is
   package Interfaces is
      --  Predefined distribution interfaces for common types

      package Bool_Distr is new Generic_Distribution (Boolean);

      package Short_Float_Distr is new Generic_Distribution (Short_Float);
      package Float_Distr is new Generic_Distribution (Float);
      package Long_Float_Distr is new Generic_Distribution (Long_Float);
      package Long_Long_Float_Distr is new
        Generic_Distribution (Long_Long_Float);

      package Short_Short_Int_Distr is new
        Generic_Distribution (Short_Short_Integer);
      package Short_Int_Distr is new Generic_Distribution (Short_Integer);
      package Int_Distr is new Generic_Distribution (Integer);
      package Long_Int_Distr is new Generic_Distribution (Long_Integer);
      package Long_Long_Int_Distr is new
        Generic_Distribution (Long_Long_Integer);
      package Long_Long_Long_Int_Distr is new
        Generic_Distribution (Long_Long_Long_Integer);

      package Natural_Distr is new Generic_Distribution (Natural);
      package Positive_Distr is new Generic_Distribution (Positive);

      package U8_Distr is new Generic_Distribution (U8);
      package U16_Distr is new Generic_Distribution (U16);
      package U32_Distr is new Generic_Distribution (U32);
      package U64_Distr is new Generic_Distribution (U64);
      package U128_Distr is new Generic_Distribution (U128);

      package I8_Distr is new Generic_Distribution (I8);
      package I16_Distr is new Generic_Distribution (I16);
      package I32_Distr is new Generic_Distribution (I32);
      package I64_Distr is new Generic_Distribution (I64);
      package I128_Distr is new Generic_Distribution (I128);
   end Interfaces;

   use Interfaces;

   --  distributions for common types

   package Bernoulli is new Rand_Distributions.Bernoulli (Bool_Distr);
   package Normal_Short_Float is new Normal (Short_Float, Short_Float_Distr);
   package Normal_Float is new Normal (Float, Float_Distr);
   package Normal_Long_Float is new Normal (Long_Float, Long_Float_Distr);
   package Normal_Long_Long_Float is new
     Normal (Long_Long_Float, Long_Long_Float_Distr);

   package Uniform_Float is new Uniform.Floating_Point (Float, Float_Distr);
   package Uniform_Long_Float is new
     Uniform.Floating_Point (Long_Float, Long_Float_Distr);
   package Uniform_Long_Long_Float is new
     Uniform.Floating_Point (Long_Long_Float, Long_Long_Float_Distr);

   package Uniform_Int is new Uniform.Discrete (Integer, Int_Distr);
   package Uniform_Long_Int is new
     Uniform.Discrete (Long_Integer, Long_Int_Distr);
   package Uniform_Long_Long_Int is new
     Uniform.Discrete (Long_Long_Integer, Long_Long_Int_Distr);

   package Uniform_Nat is new Uniform.Discrete (Natural, Natural_Distr);
   package Uniform_Pos is new Uniform.Discrete (Positive, Positive_Distr);

   package Uniform_U8 is new Uniform.Discrete (U8, U8_Distr);
   package Uniform_U16 is new Uniform.Discrete (U16, U16_Distr);
   package Uniform_U32 is new Uniform.Discrete (U32, U32_Distr);
   package Uniform_U64 is new Uniform.Discrete (U64, U64_Distr);
   package Uniform_U128 is new Uniform.Discrete (U128, U128_Distr);

   package Uniform_I8 is new Uniform.Discrete (I8, I8_Distr);
   package Uniform_I16 is new Uniform.Discrete (I16, I16_Distr);
   package Uniform_I32 is new Uniform.Discrete (I32, I32_Distr);
   package Uniform_I64 is new Uniform.Discrete (I64, I64_Distr);
   package Uniform_I128 is new Uniform.Discrete (I128, I128_Distr);

end Rand_Distributions.Instances;
