generic
   with package D is new Generic_Distribution (Boolean);
package Rand_Distributions.Bernoulli is
   type Distribution is new D.Distribution with private;

   overriding
   function Sample
     (D : Distribution; R : in out Generators.Rng'Class) return Boolean;

   generic
      type Rng (<>) is limited new Generators.Rng with private;
   function Sample_Generic (D : Distribution; R : in out Rng) return Boolean;

   subtype Probability is Long_Float range 0.0 .. 1.0;

   function Create (P : Probability) return Distribution;

   function Create
     (Numerator : Natural; Denominator : Positive) return Distribution
   is (Create (Long_Float (Numerator) / Long_Float (Denominator)))
   with Pre => Numerator <= Denominator;

   function Create (P : Float) return Distribution
   is (Create (Long_Float (P)))
   with Pre => Long_Float (P) in Probability;

private
   use all type U64;

   type Distribution is new D.Distribution with record
      Prob : U64;
   end record;

   Always_True : constant := U64'Last;
   Scale       : constant := 2.0**64;

   function Sample_Generic (D : Distribution; R : in out Rng) return Boolean
   is (D.Prob = Always_True or else R.Next < D.Prob);

   function Sample_Impl is new Sample_Generic (Generators.Rng'Class);
   pragma Inline_Always (Sample_Impl);

   overriding
   function Sample
     (D : Distribution; R : in out Generators.Rng'Class) return Boolean
   is (Sample_Impl (D, R));

   function Create (P : Probability) return Distribution
   is (if P = 1.0 then (Prob => Always_True) else (Prob => U64 (P * Scale)));
end Rand_Distributions.Bernoulli;
