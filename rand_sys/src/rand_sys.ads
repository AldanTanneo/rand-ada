--  Implementation of a random number generator (RNG) based on system entropy
--  sources. This uses the `System_Random` crate internally.

with Rand_Core.Generators;
use Rand_Core;

package Rand_Sys
  with Preelaborate
is
   type OS_Rng is new Generators.Rng with private;
   --  A random number generator based on system entropy.
   --  As this calls OS functions, it is best used as a seed for a user-space
   --  PRNG (such as the ones provided in `rand_chacha` or `rand_xoshiro`).

   overriding
   function Next (R : in out OS_Rng) return U64
   with Inline;

   overriding
   procedure Next_Bytes (R : in out OS_Rng; Buf : out Bytes)
   with Inline;

   function Get return OS_Rng
   with Inline;
   --  Get a handle to the system entropy source.
private
   type OS_Rng is new Generators.Rng with null record;
end Rand_Sys;
