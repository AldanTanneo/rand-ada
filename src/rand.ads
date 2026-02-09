with Rand_Chacha;
with Rand_Sys;
with Rand_Xoshiro256;

with Rand_Core.Generators;

package Rand
  with Preelaborate
is
   package Core renames Rand_Core;
   package ChaCha renames Rand_Chacha;
   package Xoshiro256 renames Rand_Xoshiro256;
   package Sys renames Rand_Sys;

   subtype Core_Rng is Core.Generators.Rng;

   subtype Rng is Core_Rng'Class;
   --  Random number generator type.
   --  This is a dispatching class-wide type, for ease of use.
   --  If you want to avoid the dispatching overhead, use a specific Rng
   --  implementation type.

   function Thread_Rng return Rng
   with Inline;
   --  Thread local Rng seeded with system entropy.
   --  This generator should be secure enough for most uses.

   function Small_Rng return Rng
   with Inline;
   --  Unsecure generator seeded with system entropy.
end Rand;
