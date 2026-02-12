with Ada.Numerics.Generic_Elementary_Functions;

generic
   type T is digits <>;
   with package D is new Generic_Distribution (T);
   with package Elementary_Functions is new
     Ada.Numerics.Generic_Elementary_Functions (T);
package Rand_Distributions.Normal with Pure is
   type Distribution is new D.Distribution with private;

   overriding
   function Sample (D : Distribution; R : in out Generators.Rng'Class) return T
   with Inline;

   generic
      type Rng (<>) is limited new Generators.Rng with private;
   function Sample_Generic (D : Distribution; R : in out Rng) return T;

   function Create (Mean : T := 0.0; Stddev : T := 1.0) return Distribution
   with Inline;
private
   type Distribution is new D.Distribution with record
      Mean   : T := 0.0;
      Stddev : T := 1.0;
   end record;

   function Create (Mean : T := 0.0; Stddev : T := 1.0) return Distribution
   is (Mean, Stddev);
end Rand_Distributions.Normal;
