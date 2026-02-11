with Ada.Numerics;
with Rand_Core.Utils;

package body Rand_Xoshiro256
  with Pure
is
   use all type U64;

   function Next (R : in out Xoshiro256_Rng) return U64 is
      Res : constant U64 := Utils.Rotl (R.S0 + R.S3, 23) + R.S0;
      T   : constant U64 := Utils.Shl (R.S1, 17);
   begin
      R.S2 := R.S2 xor R.S0;
      R.S3 := R.S3 xor R.S1;
      R.S1 := R.S1 xor R.S2;
      R.S0 := R.S0 xor R.S3;

      R.S2 := R.S2 xor T;
      R.S3 := Utils.Rotl (R.S3, 45);

      return Res;
   end Next;

   procedure Next_Bytes_Impl is new
     Generators.Generic_Next_Bytes (Xoshiro256_Rng);
   procedure Next_Bytes (R : in out Xoshiro256_Rng; Buf : out Bytes)
   renames Next_Bytes_Impl;

   function Create_Seeded (Seed : Seed_Type) return Xoshiro256_Rng is
      Fixed : constant U64 := U64 (Ada.Numerics.Pi * Long_Float (2.0 ** 60));

      use all type U8;
   begin
      return R : Xoshiro256_Rng do
         if (for some I in Seed'Range => Seed (I) /= 0) then
            R.S0 := Utils.From_LE_Bytes (Seed (1 .. 8));
            R.S1 := Utils.From_LE_Bytes (Seed (9 .. 16));
            R.S2 := Utils.From_LE_Bytes (Seed (17 .. 24));
            R.S3 := Utils.From_LE_Bytes (Seed (25 .. 32));
         else
            --  if all input bytes are 0, use a fixed non-zero state
            R.S0 := Fixed;
            R.S1 := Fixed + 1;
            R.S2 := Fixed + 2;
            R.S3 := Fixed + 3;
         end if;
      end return;
   end Create_Seeded;

   function From_Rng (R : in out Generators.Rng'Class) return Xoshiro256_Rng is
      S : Seed_Type;
   begin
      R.Next_Bytes (S);
      return Create_Seeded (S);
   end From_Rng;
end Rand_Xoshiro256;
