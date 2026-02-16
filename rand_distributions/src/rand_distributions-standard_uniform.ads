--  The Standard_Uniform distribution is a convenience distribution that
--  samples many standard discrete types uniformly, and several floating point
--  types over the [0, 1) interval.

with Rand_Distributions.Instances;

package Rand_Distributions.Standard_Uniform
  with Pure
is
   use Instances.Interfaces;

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
   function Sample
     (D : Distribution; R : in out Generators.Rng'Class) return Boolean
   is (R.Gen)
   with Inline;
   overriding
   function Sample
     (D : Distribution; R : in out Generators.Rng'Class) return Short_Float
   is (R.Gen)
   with Inline;
   overriding
   function Sample
     (D : Distribution; R : in out Generators.Rng'Class) return Float
   is (R.Gen)
   with Inline;
   overriding
   function Sample
     (D : Distribution; R : in out Generators.Rng'Class) return Long_Float
   is (R.Gen)
   with Inline;
   overriding
   function Sample
     (D : Distribution; R : in out Generators.Rng'Class) return Long_Long_Float
   is (R.Gen)
   with Inline;
   overriding
   function Sample
     (D : Distribution; R : in out Generators.Rng'Class)
      return Short_Short_Integer
   is (R.Gen)
   with Inline;
   overriding
   function Sample
     (D : Distribution; R : in out Generators.Rng'Class) return Short_Integer
   is (R.Gen)
   with Inline;
   overriding
   function Sample
     (D : Distribution; R : in out Generators.Rng'Class) return Integer
   is (R.Gen)
   with Inline;
   overriding
   function Sample
     (D : Distribution; R : in out Generators.Rng'Class) return Long_Integer
   is (R.Gen)
   with Inline;
   overriding
   function Sample
     (D : Distribution; R : in out Generators.Rng'Class)
      return Long_Long_Integer
   is (R.Gen)
   with Inline;
   overriding
   function Sample
     (D : Distribution; R : in out Generators.Rng'Class)
      return Long_Long_Long_Integer
   is (R.Gen)
   with Inline;
   overriding
   function Sample
     (D : Distribution; R : in out Generators.Rng'Class) return I8
   is (R.Gen)
   with Inline;
   overriding
   function Sample
     (D : Distribution; R : in out Generators.Rng'Class) return I16
   is (R.Gen)
   with Inline;
   overriding
   function Sample
     (D : Distribution; R : in out Generators.Rng'Class) return I32
   is (R.Gen)
   with Inline;
   overriding
   function Sample
     (D : Distribution; R : in out Generators.Rng'Class) return I64
   is (R.Gen)
   with Inline;
   overriding
   function Sample
     (D : Distribution; R : in out Generators.Rng'Class) return I128
   is (R.Gen)
   with Inline;
   overriding
   function Sample
     (D : Distribution; R : in out Generators.Rng'Class) return U8
   is (R.Gen)
   with Inline;
   overriding
   function Sample
     (D : Distribution; R : in out Generators.Rng'Class) return U16
   is (R.Gen)
   with Inline;
   overriding
   function Sample
     (D : Distribution; R : in out Generators.Rng'Class) return U32
   is (R.Gen)
   with Inline;
   overriding
   function Sample
     (D : Distribution; R : in out Generators.Rng'Class) return U64
   is (R.Gen)
   with Inline;
   overriding
   function Sample
     (D : Distribution; R : in out Generators.Rng'Class) return U128
   is (R.Gen)
   with Inline;
end Rand_Distributions.Standard_Uniform;
