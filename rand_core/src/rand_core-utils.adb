pragma Warnings (Off, """System.Byte_Swapping"" is an internal GNAT unit");
with System.Byte_Swapping;
pragma Warnings (On, """System.Byte_Swapping"" is an internal GNAT unit");

package body Rand_Core.Utils
  with Pure
is
   use all type U32;

   function Swap_Bytes (X : U32) return U32
   is (System.Byte_Swapping.Bswap_32 (X));

   function From_LE_Bytes (Buf : Bytes4) return U32
   is (case System.Default_Bit_Order is
         when System.Low_Order_First  => From_NE_Bytes (Buf),
         when System.High_Order_First => Swap_Bytes (From_NE_Bytes (Buf)));

   function To_LE_Bytes (X : U32) return Bytes4
   is (case System.Default_Bit_Order is
         when System.Low_Order_First  => To_NE_Bytes (X),
         when System.High_Order_First => To_NE_Bytes (Swap_Bytes (X)));

   function From_BE_Bytes (Buf : Bytes4) return U32
   is (case System.Default_Bit_Order is
         when System.High_Order_First => From_NE_Bytes (Buf),
         when System.Low_Order_First  => Swap_Bytes (From_NE_Bytes (Buf)));

   function To_BE_Bytes (X : U32) return Bytes4
   is (case System.Default_Bit_Order is
         when System.High_Order_First => To_NE_Bytes (X),
         when System.Low_Order_First  => To_NE_Bytes (Swap_Bytes (X)));

   use all type U64;

   function Swap_Bytes (X : U64) return U64
   is (System.Byte_Swapping.Bswap_64 (X));

   function From_LE_Bytes (Buf : Bytes8) return U64
   is (case System.Default_Bit_Order is
         when System.Low_Order_First  => From_NE_Bytes (Buf),
         when System.High_Order_First => Swap_Bytes (From_NE_Bytes (Buf)));

   function To_LE_Bytes (X : U64) return Bytes8
   is (case System.Default_Bit_Order is
         when System.Low_Order_First  => To_NE_Bytes (X),
         when System.High_Order_First => To_NE_Bytes (Swap_Bytes (X)));

   function From_BE_Bytes (Buf : Bytes8) return U64
   is (case System.Default_Bit_Order is
         when System.High_Order_First => From_NE_Bytes (Buf),
         when System.Low_Order_First  => Swap_Bytes (From_NE_Bytes (Buf)));

   function To_BE_Bytes (X : U64) return Bytes8
   is (case System.Default_Bit_Order is
         when System.High_Order_First => To_NE_Bytes (X),
         when System.Low_Order_First  => To_NE_Bytes (Swap_Bytes (X)));

   use all type U128;

   Mask_32 : constant U64 := (2 ** 32) - 1;
   Mask_64 : constant U128 := (2 ** 64) - 1;

   function Swap_Bytes (X : U128) return U128 is
      Hi : constant U64 := U64 (Shr (X, 64));
      Lo : constant U64 := U64 (X and Mask_64);
   begin
      return Shl (U128 (Swap_Bytes (Lo)), 64) or U128 (Swap_Bytes (Hi));
   end Swap_Bytes;

   function From_LE_Bytes (Buf : Bytes16) return U128
   is (case System.Default_Bit_Order is
         when System.Low_Order_First  => From_NE_Bytes (Buf),
         when System.High_Order_First => Swap_Bytes (From_NE_Bytes (Buf)));

   function To_LE_Bytes (X : U128) return Bytes16
   is (case System.Default_Bit_Order is
         when System.Low_Order_First  => To_NE_Bytes (X),
         when System.High_Order_First => To_NE_Bytes (Swap_Bytes (X)));

   function From_BE_Bytes (Buf : Bytes16) return U128
   is (case System.Default_Bit_Order is
         when System.High_Order_First => From_NE_Bytes (Buf),
         when System.Low_Order_First  => Swap_Bytes (From_NE_Bytes (Buf)));

   function To_BE_Bytes (X : U128) return Bytes16
   is (case System.Default_Bit_Order is
         when System.High_Order_First => To_NE_Bytes (X),
         when System.Low_Order_First  => To_NE_Bytes (Swap_Bytes (X)));

   procedure Wide_Mul (X, Y : U32; Hi, Lo : out U32) is
      Z : constant U64 := U64 (X) * U64 (Y);
   begin
      Hi := U32 (Shr (Z, 32));
      Lo := U32 (Z and Mask_32);
   end Wide_Mul;

   procedure Wide_Mul (X, Y : U64; Hi, Lo : out U64) is
      Z : constant U128 := U128 (X) * U128 (Y);
   begin
      Hi := U64 (Shr (Z, 64));
      Lo := U64 (Z and Mask_64);
   end Wide_Mul;

   procedure Wide_Mul (X, Y : U128; Hi, Lo : out U128) is
      Xh : constant U128 := Shr (X, 64);
      Xl : constant U128 := X and Mask_64;
      Yh : constant U128 := Shr (Y, 64);
      Yl : constant U128 := Y and Mask_64;

      Z : constant U128 := Xh * Yl + Xl * Yh;
   begin
      Hi := Xh * Yh + Shr (Z, 64);
      Lo := Xl * Yl + Shl (Z, 64);
   end Wide_Mul;

end Rand_Core.Utils;
