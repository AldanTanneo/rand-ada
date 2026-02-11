with Rand_Core.Generators;
use Rand_Core;

package Rand_Sys
  with Preelaborate
is
   type OS_Rng is new Generators.Rng with private;

   overriding
   function Next (R : in out OS_Rng) return U64
   with Inline;

   overriding
   procedure Next_Bytes (R : in out OS_Rng; Buf : out Bytes)
   with Inline;

   function Get return OS_Rng
   with Inline;
private
   type OS_Rng is new Generators.Rng with null record;
end Rand_Sys;
