with Rand_Core.Generators;
use Rand_Core;

package Rand_Distributions is

   generic
      type T (<>) is limited private;
   package Generic_Distribution is
      type Distribution is limited interface;

      function Sample
        (D : Distribution; R : in out Generators.Rng'Class) return T
      is abstract;
   end Generic_Distribution;

end Rand_Distributions;
