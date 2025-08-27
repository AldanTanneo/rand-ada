with Ada.Unchecked_Conversion;

package Rand_Core.Utils is
   subtype Bytes4 is Bytes (1 .. 4);
   subtype Bytes8 is Bytes (1 .. 8);

   --  U32 functions

   function From_LE_Bytes (Buf : Bytes4) return U32
   with Inline;

   function To_LE_Bytes (X : U32) return Bytes4
   with Inline;

   function From_BE_Bytes (Buf : Bytes4) return U32
   with Inline;

   function To_BE_Bytes (X : U32) return Bytes4
   with Inline;

   function From_NE_Bytes is new
     Ada.Unchecked_Conversion (Source => Bytes4, Target => U32);

   function To_NE_Bytes is new
     Ada.Unchecked_Conversion (Source => U32, Target => Bytes4);

   function Shl (X : U32; Amnt : Natural) return U32
   renames Interfaces.Shift_Left;

   function Shr (X : U32; Amnt : Natural) return U32
   renames Interfaces.Shift_Right;

   function Rotl (X : U32; Amnt : Natural) return U32
   renames Interfaces.Rotate_Left;

   function Rotr (X : U32; Amnt : Natural) return U32
   renames Interfaces.Rotate_Right;

   --  U64 functions

   function From_LE_Bytes (Buf : Bytes8) return U64
   with Inline;

   function To_LE_Bytes (X : U64) return Bytes8
   with Inline;

   function From_BE_Bytes (Buf : Bytes8) return U64
   with Inline;

   function To_BE_Bytes (X : U64) return Bytes8
   with Inline;

   function From_NE_Bytes is new
     Ada.Unchecked_Conversion (Source => Bytes8, Target => U64);

   function To_NE_Bytes is new
     Ada.Unchecked_Conversion (Source => U64, Target => Bytes8);

   function Shl (X : U64; Amnt : Natural) return U64
   renames Interfaces.Shift_Left;

   function Shr (X : U64; Amnt : Natural) return U64
   renames Interfaces.Shift_Right;

   function Rotl (X : U64; Amnt : Natural) return U64
   renames Interfaces.Rotate_Left;

   function Rotr (X : U64; Amnt : Natural) return U64
   renames Interfaces.Rotate_Right;

   -- U128 functions

   function Shl (X : U128; Amnt : Natural) return U128
   renames Interfaces.Shift_Left;

   function Shr (X : U128; Amnt : Natural) return U128
   renames Interfaces.Shift_Right;

   function Rotl (X : U128; Amnt : Natural) return U128
   renames Interfaces.Rotate_Left;

   function Rotr (X : U128; Amnt : Natural) return U128
   renames Interfaces.Rotate_Right;

   -- Wide multiplication

   procedure Wide_Mul (X, Y : U32; Hi, Lo : out U32)
   with Inline;

   procedure Wide_Mul (X, Y : U64; Hi, Lo : out U64)
   with Inline;

   procedure Wide_Mul (X, Y : U128; Hi, Lo : out U128)
   with Inline;
end Rand_Core.Utils;
