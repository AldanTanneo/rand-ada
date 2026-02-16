with Rand_Core.Generators;
use Rand_Core;

package Rand_Distributions
  with Pure
is

   generic
      type T (<>) is limited private;
   package Generic_Distribution is
      --  A generic definition for random distributions.
      --  See the `Instances` child package for preinstantiated
      --  distributions for common types.

      type Distribution is limited interface;

      function Sample
        (D : Distribution; R : in out Generators.Rng'Class) return T
      is abstract;
      --  Sample the distribution with a provided random number generator.
   end Generic_Distribution;

end Rand_Distributions;
