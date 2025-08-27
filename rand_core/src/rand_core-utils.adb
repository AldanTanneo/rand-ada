with GNAT.Byte_Swapping;
with System;

package body Rand_Core.Utils is
   use all type U32;
   use all type U128;

   function Swap is new GNAT.Byte_Swapping.Swapped4 (U32);

   function From_LE_Bytes (Buf : Bytes4) return U32
   is (case System.Default_Bit_Order is
         when System.Low_Order_First => From_NE_Bytes (Buf),
         when System.High_Order_First => Swap (From_NE_Bytes (Buf)));

   function To_LE_Bytes (X : U32) return Bytes4
   is (case System.Default_Bit_Order is
         when System.Low_Order_First => To_NE_Bytes (X),
         when System.High_Order_First => To_NE_Bytes (Swap (X)));

   function From_BE_Bytes (Buf : Bytes4) return U32
   is (case System.Default_Bit_Order is
         when System.High_Order_First => From_NE_Bytes (Buf),
         when System.Low_Order_First => Swap (From_NE_Bytes (Buf)));

   function To_BE_Bytes (X : U32) return Bytes4
   is (case System.Default_Bit_Order is
         when System.High_Order_First => To_NE_Bytes (X),
         when System.Low_Order_First => To_NE_Bytes (Swap (X)));

   use all type U64;

   function Swap is new GNAT.Byte_Swapping.Swapped8 (U64);

   function From_LE_Bytes (Buf : Bytes8) return U64
   is (case System.Default_Bit_Order is
         when System.Low_Order_First => From_NE_Bytes (Buf),
         when System.High_Order_First => Swap (From_NE_Bytes (Buf)));

   function To_LE_Bytes (X : U64) return Bytes8
   is (case System.Default_Bit_Order is
         when System.Low_Order_First => To_NE_Bytes (X),
         when System.High_Order_First => To_NE_Bytes (Swap (X)));

   function From_BE_Bytes (Buf : Bytes8) return U64
   is (case System.Default_Bit_Order is
         when System.High_Order_First => From_NE_Bytes (Buf),
         when System.Low_Order_First => Swap (From_NE_Bytes (Buf)));

   function To_BE_Bytes (X : U64) return Bytes8
   is (case System.Default_Bit_Order is
         when System.High_Order_First => To_NE_Bytes (X),
         when System.Low_Order_First => To_NE_Bytes (Swap (X)));

   Mask_32 : constant U64 := (2**32) - 1;
   Mask_64 : constant U128 := (2**64) - 1;

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
