package Rand.Distributions.Standard_Uniform is
   type Distribution is
     new Bool_Distr.Distribution
     and Short_Float_Distr.Distribution
     and Float_Distr.Distribution
     and Long_Float_Distr.Distribution
     and Long_Long_Float_Distr.Distribution
     and Short_Short_Int_Distr.Distribution
     and Short_Int_Distr.Distribution
     and Int_Distr.Distribution
     and Long_Int_Distr.Distribution
     and Long_Long_Int_Distr.Distribution
     and Long_Long_Long_Int_Distr.Distribution
     and I8_Distr.Distribution
     and I16_Distr.Distribution
     and I32_Distr.Distribution
     and I64_Distr.Distribution
     and I128_Distr.Distribution
     and U8_Distr.Distribution
     and U16_Distr.Distribution
     and U32_Distr.Distribution
     and U64_Distr.Distribution
     and U128_Distr.Distribution
   with null record;

   overriding
   function Sample (D : Distribution; R : in out Rng) return Boolean
   is (R.Gen)
   with Inline;
   overriding
   function Sample (D : Distribution; R : in out Rng) return Short_Float
   is (R.Gen)
   with Inline;
   overriding
   function Sample (D : Distribution; R : in out Rng) return Float
   is (R.Gen)
   with Inline;
   overriding
   function Sample (D : Distribution; R : in out Rng) return Long_Float
   is (R.Gen)
   with Inline;
   overriding
   function Sample (D : Distribution; R : in out Rng) return Long_Long_Float
   is (R.Gen)
   with Inline;
   overriding
   function Sample
     (D : Distribution; R : in out Rng) return Short_Short_Integer
   is (R.Gen)
   with Inline;
   overriding
   function Sample (D : Distribution; R : in out Rng) return Short_Integer
   is (R.Gen)
   with Inline;
   overriding
   function Sample (D : Distribution; R : in out Rng) return Integer
   is (R.Gen)
   with Inline;
   overriding
   function Sample (D : Distribution; R : in out Rng) return Long_Integer
   is (R.Gen)
   with Inline;
   overriding
   function Sample (D : Distribution; R : in out Rng) return Long_Long_Integer
   is (R.Gen)
   with Inline;
   overriding
   function Sample
     (D : Distribution; R : in out Rng) return Long_Long_Long_Integer
   is (R.Gen)
   with Inline;
   overriding
   function Sample (D : Distribution; R : in out Rng) return I8
   is (R.Gen)
   with Inline;
   overriding
   function Sample (D : Distribution; R : in out Rng) return I16
   is (R.Gen)
   with Inline;
   overriding
   function Sample (D : Distribution; R : in out Rng) return I32
   is (R.Gen)
   with Inline;
   overriding
   function Sample (D : Distribution; R : in out Rng) return I64
   is (R.Gen)
   with Inline;
   overriding
   function Sample (D : Distribution; R : in out Rng) return I128
   is (R.Gen)
   with Inline;
   overriding
   function Sample (D : Distribution; R : in out Rng) return U8
   is (R.Gen)
   with Inline;
   overriding
   function Sample (D : Distribution; R : in out Rng) return U16
   is (R.Gen)
   with Inline;
   overriding
   function Sample (D : Distribution; R : in out Rng) return U32
   is (R.Gen)
   with Inline;
   overriding
   function Sample (D : Distribution; R : in out Rng) return U64
   is (R.Gen)
   with Inline;
   overriding
   function Sample (D : Distribution; R : in out Rng) return U128
   is (R.Gen)
   with Inline;
end Rand.Distributions.Standard_Uniform;
