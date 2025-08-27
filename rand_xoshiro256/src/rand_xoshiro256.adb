with Ada.Numerics;
with Rand_Core.Utils;

package body Rand_Xoshiro256 is
   use all type U64;

   overriding
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

   overriding
   procedure Next_Bytes (R : in out Xoshiro256_Rng; Buf : out Bytes) is
      Chunks : constant Natural := Buf'Length / 8;
      Extra  : constant Natural := Buf'Length mod 8;
   begin
      for I in 1 .. Chunks loop
         Buf (Buf'First + 8 * (I - 1) .. Buf'First + 8 * I - 1) :=
           Utils.To_LE_Bytes (R.Next);
      end loop;
      if Extra /= 0 then
         Buf (Buf'First + 8 * Chunks .. Buf'Last) :=
           Utils.To_LE_Bytes (R.Next) (1 .. Extra);
      end if;
   end Next_Bytes;

   function Create_Seeded (Seed : Seed_Type) return Xoshiro256_Rng is
      Phi : constant U64 := U64 (Ada.Numerics.Pi * Long_Float (2.0**60));

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
            R.S0 := Phi;
            R.S1 := Phi + 1;
            R.S2 := Phi + 2;
            R.S3 := Phi + 3;
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
