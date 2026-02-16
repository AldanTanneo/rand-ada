--  Utility functions for manipulating machine (unsigned) integers.

with Ada.Unchecked_Conversion;

package Rand_Core.Utils
  with Pure
is
   subtype Bytes4 is Bytes (1 .. 4);
   subtype Bytes8 is Bytes (1 .. 8);
   subtype Bytes16 is Bytes (1 .. 16);

   --  U32 functions

   function From_LE_Bytes (Buf : Bytes4) return U32
   with Inline;
   --  Get the unsigned integer represented by the input bytes, in
   --  little-endian order.

   function To_LE_Bytes (X : U32) return Bytes4
   with Inline;
   --  Get the bytes representing the given unsigned integer, in
   --  little-endian order.

   function From_BE_Bytes (Buf : Bytes4) return U32
   with Inline;
   --  Get the unsigned integer represented by the input bytes, in
   --  big-endian order.

   function To_BE_Bytes (X : U32) return Bytes4
   with Inline;
   --  Get the bytes representing the given unsigned integer, in
   --  big-endian order.

   function From_NE_Bytes is new
     Ada.Unchecked_Conversion (Source => Bytes4, Target => U32);
   --  Get the unsigned integer represented by the input bytes, in
   --  the native endianness order.

   function To_NE_Bytes is new
     Ada.Unchecked_Conversion (Source => U32, Target => Bytes4);
   --  Get the bytes representing the given unsigned integer, in
   --  the native endianness order.

   function Shl (X : U32; Amnt : Natural) return U32
   renames Interfaces.Shift_Left;
   --  Shift the given unsigned integer by `Amnt` bits to the left. Equivalent
   --  to `X * 2**Amnt`.

   function Shr (X : U32; Amnt : Natural) return U32
   renames Interfaces.Shift_Right;
   --  Shift the given unsigned integer by `Amnt` bits to the right. Equivalent
   --  to `X / 2**Amnt`.

   function Rotl (X : U32; Amnt : Natural) return U32
   renames Interfaces.Rotate_Left;
   --  Rotates the given unsigned integer by `Amnt` bits to the left.
   --  Equivalent to `X * 2**(Amnt mod 32) + X / 2**(32 - Amnt mod 32)`.

   function Rotr (X : U32; Amnt : Natural) return U32
   renames Interfaces.Rotate_Right;
   --  Rotates the given unsigned integer by `Amnt` bits to the right.
   --  Equivalent to `X / 2**(Amnt mod 32) + X * 2**(32 - Amnt mod 32)`.

   --  U64 functions

   function From_LE_Bytes (Buf : Bytes8) return U64
   with Inline;
   --  Get the unsigned integer represented by the input bytes, in
   --  little-endian order.

   function To_LE_Bytes (X : U64) return Bytes8
   with Inline;
   --  Get the bytes representing the given unsigned integer, in
   --  little-endian order.

   function From_BE_Bytes (Buf : Bytes8) return U64
   with Inline;
   --  Get the unsigned integer represented by the input bytes, in
   --  big-endian order.

   function To_BE_Bytes (X : U64) return Bytes8
   with Inline;
   --  Get the bytes representing the given unsigned integer, in
   --  big-endian order.

   function From_NE_Bytes is new
     Ada.Unchecked_Conversion (Source => Bytes8, Target => U64);
   --  Get the unsigned integer represented by the input bytes, in
   --  the native endianness order.

   function To_NE_Bytes is new
     Ada.Unchecked_Conversion (Source => U64, Target => Bytes8);
   --  Get the bytes representing the given unsigned integer, in
   --  the native endianness order.

   function Shl (X : U64; Amnt : Natural) return U64
   renames Interfaces.Shift_Left;
   --  Shift the given unsigned integer by `Amnt` bits to the left. Equivalent
   --  to `X * 2**Amnt`.

   function Shr (X : U64; Amnt : Natural) return U64
   renames Interfaces.Shift_Right;
   --  Shift the given unsigned integer by `Amnt` bits to the right. Equivalent
   --  to `X / 2**Amnt`.

   function Rotl (X : U64; Amnt : Natural) return U64
   renames Interfaces.Rotate_Left;
   --  Rotates the given unsigned integer by `Amnt` bits to the left.
   --  Equivalent to `X * 2**(Amnt mod 64) + X / 2**(64 - Amnt mod 64)`.

   function Rotr (X : U64; Amnt : Natural) return U64
   renames Interfaces.Rotate_Right;
   --  Rotates the given unsigned integer by `Amnt` bits to the right.
   --  Equivalent to `X / 2**(Amnt mod 64) + X * 2**(64 - Amnt mod 64)`.

   -- U128 functions

   function From_LE_Bytes (Buf : Bytes16) return U128
   with Inline;
   --  Get the unsigned integer represented by the input bytes, in
   --  little-endian order.

   function To_LE_Bytes (X : U128) return Bytes16
   with Inline;
   --  Get the bytes representing the given unsigned integer, in
   --  little-endian order.

   function From_BE_Bytes (Buf : Bytes16) return U128
   with Inline;
   --  Get the unsigned integer represented by the input bytes, in
   --  big-endian order.

   function To_BE_Bytes (X : U128) return Bytes16
   with Inline;
   --  Get the bytes representing the given unsigned integer, in
   --  big-endian order.

   function From_NE_Bytes is new
     Ada.Unchecked_Conversion (Source => Bytes16, Target => U128);
   --  Get the unsigned integer represented by the input bytes, in
   --  the native endianness order.

   function To_NE_Bytes is new
     Ada.Unchecked_Conversion (Source => U128, Target => Bytes16);
   --  Get the bytes representing the given unsigned integer, in
   --  the native endianness order.

   function Shl (X : U128; Amnt : Natural) return U128
   renames Interfaces.Shift_Left;
   --  Shift the given unsigned integer by `Amnt` bits to the left. Equivalent
   --  to `X * 2**Amnt`.

   function Shr (X : U128; Amnt : Natural) return U128
   renames Interfaces.Shift_Right;
   --  Shift the given unsigned integer by `Amnt` bits to the right. Equivalent
   --  to `X / 2**Amnt`.

   function Rotl (X : U128; Amnt : Natural) return U128
   renames Interfaces.Rotate_Left;
   --  Rotates the given unsigned integer by `Amnt` bits to the left.
   --  Equivalent to `X * 2**(Amnt mod 128) + X / 2**(128 - Amnt mod 128)`.

   function Rotr (X : U128; Amnt : Natural) return U128
   renames Interfaces.Rotate_Right;
   --  Rotates the given unsigned integer by `Amnt` bits to the right.
   --  Equivalent to `X / 2**(Amnt mod 128) + X * 2**(128 - Amnt mod 128)`.

   -- Wide multiplication

   procedure Wide_Mul (X, Y : U32; Hi, Lo : out U32)
   with Inline;
   --  Outputs the result of `X * Y` to the `Hi` and `Lo` parameters
   --  so that `X * Y = Hi * 2**32 + Lo`.

   procedure Wide_Mul (X, Y : U64; Hi, Lo : out U64)
   with Inline;
   --  Outputs the result of `X * Y` to the `Hi` and `Lo` parameters
   --  so that `X * Y = Hi * 2**64 + Lo`.

   procedure Wide_Mul (X, Y : U128; Hi, Lo : out U128)
   with Inline;
   --  Outputs the result of `X * Y` to the `Hi` and `Lo` parameters
   --  so that `X * Y = Hi * 2**128 + Lo`.
end Rand_Core.Utils;
