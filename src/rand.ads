with Rand_Chacha;
with Rand_Sys;
with Rand_Xoshiro256;

with Rand_Core.Generators;

package Rand is
   package Core renames Rand_Core;
   package ChaCha renames Rand_Chacha;
   package Xoshiro256 renames Rand_Xoshiro256;
   package Sys renames Rand_Sys;

   subtype Bytes is Rand_Core.Bytes;
   subtype Rng is Core.Generators.Rng;

   function Thread_Rng return Rng'Class
   with Inline;
end Rand;
