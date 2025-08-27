with Rand_Core.Generators;
use Rand_Core;

package Rand_Sys is
   type OS_Rng is new Generators.Rng with private;

   overriding
   function Next (R : in out OS_Rng) return U64;

   overriding
   procedure Next_Bytes (R : in out OS_Rng; Buf : out Bytes);

   function Get return OS_Rng;
private
   type OS_Rng is new Generators.Rng with null record;
end Rand_Sys;
