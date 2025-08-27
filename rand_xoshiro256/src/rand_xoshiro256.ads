with Rand_Core.Generators;
use Rand_Core;

package Rand_Xoshiro256 is
   type Xoshiro256_Rng (<>) is limited new Generators.Rng with private;

   overriding
   function Next (R : in out Xoshiro256_Rng) return U64;

   overriding
   procedure Next_Bytes (R : in out Xoshiro256_Rng; Buf : out Bytes);

   subtype Seed_Type is Bytes (1 .. 32);
   function Create_Seeded (Seed : Seed_Type) return Xoshiro256_Rng;

   function From_Rng (R : in out Generators.Rng'Class) return Xoshiro256_Rng;

private
   type Xoshiro256_Rng is limited new Generators.Rng with record
      S0, S1, S2, S3 : U64;
   end record;
end Rand_Xoshiro256;
