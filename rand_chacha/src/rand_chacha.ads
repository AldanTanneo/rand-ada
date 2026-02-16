--  A secure random number generator (RNG) based on the ChaCha stream cipher.
--  The RNG is available in three variants, all using the same algorithm but
--  with a different number of rounds: `ChaCha8`, `ChaCha12` and `ChaCha20`.
--
--  This is a well known and widely analyzed PRNG, suitable for use in
--  security sensitive contexts and cryptography, as long as it is
--  properly initialized with an unpredictable seed.
--  See the `rand_sys` crate for a way to initialize this RNG with system
--  entropy sources.

with Rand_Core.Generators;
use Rand_Core;

package Rand_Chacha
  with Pure
is
   type ChaCha_Kind is (ChaCha8, ChaCha12, ChaCha20);
   --  Determines the number of rounds in the RNG
   for ChaCha_Kind use (ChaCha8 => 4, ChaCha12 => 6, ChaCha20 => 10);
   --  set enum repr to be number of double rounds in the algorithm

   type ChaCha_Rng (Kind : ChaCha_Kind := ChaCha12) is limited
     new Generators.Rng with private;

   subtype ChaCha8_Rng is ChaCha_Rng (ChaCha8);
   subtype ChaCha12_Rng is ChaCha_Rng (ChaCha12);
   subtype ChaCha20_Rng is ChaCha_Rng (ChaCha20);

   overriding
   function Next (R : in out ChaCha_Rng) return U64
   with Inline;

   overriding
   procedure Next_Bytes (R : in out ChaCha_Rng; Buf : out Bytes);

   subtype Seed_Type is Bytes (1 .. 32);
   function Create_Seeded
     (Key : Seed_Type; Kind : ChaCha_Kind := ChaCha12) return ChaCha_Rng
   with Inline;
   --  Create a new instance of a ChaCha RNG from a given seed and kind.
   --  Defaults to the middle security level, `ChaCha12`, although many
   --  argue `ChaCha8` is sufficient.

   function From_Rng
     (R : in out Generators.Rng'Class; Kind : ChaCha_Kind := ChaCha12)
      return ChaCha_Rng
   with Inline;
   --  Create a ChaCha PRNG with a random seed from the given RNG.
   --  This should be used to initialize the RNG with a trusted, unpredictable
   --  entropy source, such as the system RNG implementation provided in
   --  `rand_sys`.

private
   subtype State_Range is Natural range 0 .. 15;
   type State_Array is array (State_Range) of U32;

   subtype State_Byte_Range is Positive range 1 .. 64;
   subtype State_Bytes is Bytes (State_Byte_Range);

   type ChaCha_Rng (Kind : ChaCha_Kind) is limited new Generators.Rng
   with record
      State : State_Array;

      Current     : State_Bytes;
      Current_Pos : Positive;
   end record;
end Rand_Chacha;
