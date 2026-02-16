--  Implementation of a fast pseudo random number generator (PRNG) based on the
--  Xoshiro256++ algorithm. This PRNG is not suitable for use in security
--  sensitive contexts.

with Rand_Core.Generators;
use Rand_Core;

package Rand_Xoshiro256
  with Pure
is
   type Xoshiro256_Rng (<>) is limited new Generators.Rng with private;
   --  A fast, unsecure random number generator.

   overriding
   function Next (R : in out Xoshiro256_Rng) return U64
   with Inline;

   overriding
   procedure Next_Bytes (R : in out Xoshiro256_Rng; Buf : out Bytes)
   with Inline;

   subtype Seed_Type is Bytes (1 .. 32);
   function Create_Seeded (Seed : Seed_Type) return Xoshiro256_Rng
   with Inline;
   --  Create a Xoshiro256 PRNG from the given seed bytes. If the input bytes
   --  are all zero, this function uses a fixed non-zero seed.

   function From_Rng (R : in out Generators.Rng'Class) return Xoshiro256_Rng
   with Inline;
   --  Create a Xoshiro256 PRNG with a random seed from the given RNG.
   --  This can be useful to initialize a fast RNG from a slower, different
   --  randomness source (such as system entropy like in the `rand_sys` crate,
   --  or a properly initialized `rand_chacha` RNG).

private
   type Xoshiro256_Rng is limited new Generators.Rng with record
      S0, S1, S2, S3 : U64;
   end record;
end Rand_Xoshiro256;
