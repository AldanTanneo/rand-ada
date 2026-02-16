with Rand_Core.Utils;
use Rand_Core;

procedure Tests.Byte_Ops is
   use type U32;
   use type U64;
   use type U128;

   B32  : constant Utils.Bytes4 := [for I in 1 .. 4 => U8 (I)];
   B64  : constant Utils.Bytes8 := [for I in 1 .. 8 => U8 (I)];
   B128 : constant Utils.Bytes16 := [for I in 1 .. 16 => U8 (I)];

   X32  : constant U32 := 16#04_03_02_01#;
   X64  : constant U64 := 16#08_07_06_05_04_03_02_01#;
   X128 : constant U128 := 16#10_0f_0e_0d_0c_0b_0a_09_08_07_06_05_04_03_02_01#;

   X32_Swapped  : constant U32 := 16#01_02_03_04#;
   X64_Swapped  : constant U64 := 16#01_02_03_04_05_06_07_08#;
   X128_Swapped : constant U128 :=
     16#01_02_03_04_05_06_07_08_09_0a_0b_0c_0d_0e_0f_10#;
begin
   Assert (Utils.From_LE_Bytes (B32) = X32);
   Assert (B32 = Utils.To_LE_Bytes (X32));
   Assert (Utils.From_LE_Bytes (B64) = X64);
   Assert (B64 = Utils.To_LE_Bytes (X64));
   Assert (Utils.From_LE_Bytes (B128) = X128);
   Assert (B128 = Utils.To_LE_Bytes (X128));

   Assert (Utils.Swap_Bytes (X32) = X32_Swapped);
   Assert (Utils.Swap_Bytes (X64) = X64_Swapped);
   Assert (Utils.Swap_Bytes (X128) = X128_Swapped);

   Assert (Utils.From_BE_Bytes (B32) = X32_Swapped);
   Assert (B32 = Utils.To_BE_Bytes (X32_Swapped));
   Assert (Utils.From_BE_Bytes (B64) = X64_Swapped);
   Assert (B64 = Utils.To_BE_Bytes (X64_Swapped));
   Assert (Utils.From_BE_Bytes (B128) = X128_Swapped);
   Assert (B128 = Utils.To_BE_Bytes (X128_Swapped));
end Tests.Byte_Ops;
