package Rand_Distributions.Uniform is

   generic
      type T is digits <>;
      with package D is new Generic_Distribution (T);
   package Floating_Point is
      type Distribution is new D.Distribution with private;

      overriding
      function Sample
        (D : Distribution; R : in out Generators.Rng'Class) return T;
      --  Sample a random floating point value in the range of the
      --  distribution

      generic
         type Rng (<>) is limited new Generators.Rng with private;
      function Sample_Generic (D : Distribution; R : in out Rng) return T;
      --  Sample a random floating point value in the range of the
      --  distribution

      function Create (Low : T := 0.0; High : T := 1.0) return Distribution
      with Pre => Low < High;
      --  Create a uniform distribution over [Low, High). This function can be
      --  expensive, so keep the created value around as much as possible.

   private
      subtype B is T'Base;

      type Distribution is new D.Distribution with record
         Offset : T;
         Scale  : B;
      end record;
   end Floating_Point;

   generic
      type T is (<>);
      with package D is new Generic_Distribution (T);
   package Discrete is
      type Distribution is new D.Distribution with private;

      overriding
      function Sample
        (D : Distribution; R : in out Generators.Rng'Class) return T;
      --  Sample a random discrete value in the range [Low, High] (inclusive
      --  on both ends)

      generic
         type Rng (<>) is limited new Generators.Rng with private;
      function Sample_Generic (D : Distribution; R : in out Rng) return T;

      function Create
        (Low : T := T'First; High : T := T'Last) return Distribution
      with Pre => Low <= High;

   private
      subtype B is T'Base;
      pragma
        Compile_Time_Error
          (B'Object_Size > 128,
           "cannot generate discrete values wider than 128 bits");

      type Distribution is new D.Distribution with record
         Low          : T;
         Span, Thresh : U128;
      end record;
   end Discrete;

end Rand_Distributions.Uniform;
