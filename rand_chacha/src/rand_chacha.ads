with Rand_Core.Generators;
use Rand_Core;

package Rand_Chacha is
   type ChaCha_Kind is (ChaCha8, ChaCha12, ChaCha20);
   type ChaCha_Rng (Kind : ChaCha_Kind) is limited
     new Generators.Rng with private;

   overriding
   function Next (R : in out ChaCha_Rng) return U64;

   overriding
   procedure Next_Bytes (R : in out ChaCha_Rng; Buf : out Bytes);

   subtype Seed_Type is Bytes (1 .. 32);
   function Create_Seeded
     (Key : Seed_Type; Kind : ChaCha_Kind := ChaCha12) return ChaCha_Rng;

   function From_Rng
     (R : in out Generators.Rng'Class; Kind : ChaCha_Kind := ChaCha12)
      return ChaCha_Rng;

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
