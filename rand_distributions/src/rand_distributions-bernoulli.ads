generic
   with package D is new Generic_Distribution (Boolean);
package Rand_Distributions.Bernoulli with Pure is
   type Distribution is new D.Distribution with private;

   overriding
   function Sample
     (D : Distribution; R : in out Generators.Rng'Class) return Boolean
   with Inline;
   --  Sample a boolean value which is True with probability P

   generic
      type Rng (<>) is limited new Generators.Rng with private;
   function Sample_Generic (D : Distribution; R : in out Rng) return Boolean;
   --  Sample a boolean value which is True with probability P

   subtype Probability is Long_Float range 0.0 .. 1.0;

   function Create (P : Probability) return Distribution
   with Inline;
   --  Create a Bernoulli distribution with probability P

   function Create
     (Numerator : Natural; Denominator : Positive) return Distribution
   with Pre => Numerator <= Denominator, Inline;
   --  Create a Bernoulli distribution with probability
   --  P = Numerator/Denominator

private
   use all type U64;

   type Distribution is new D.Distribution with record
      Prob : U64;
   end record;

   Always_True : constant := U64'Last;
   Scale       : constant := 2.0 ** 64;

   function Sample_Generic (D : Distribution; R : in out Rng) return Boolean
   is (D.Prob = Always_True or else R.Next < D.Prob);

   function Sample_Impl is new Sample_Generic (Generators.Rng'Class);
   pragma Inline_Always (Sample_Impl);

   function Sample
     (D : Distribution; R : in out Generators.Rng'Class) return Boolean
   renames Sample_Impl;

   function Create (P : Probability) return Distribution
   is (if P = 1.0
       then (Prob => Always_True)
       else (Prob => U64 (Long_Float'Floor (P * Scale))));

   function Create
     (Numerator : Natural; Denominator : Positive) return Distribution
   is (if Numerator = Denominator
       then (Prob => Always_True)
       else Create (Long_Float (Numerator) / Long_Float (Denominator)));
end Rand_Distributions.Bernoulli;
