with Interfaces;

package Rand_Core is
   subtype U8 is Interfaces.Unsigned_8;
   subtype U16 is Interfaces.Unsigned_16;
   subtype U32 is Interfaces.Unsigned_32;
   subtype U64 is Interfaces.Unsigned_64;
   subtype U128 is Interfaces.Unsigned_128;

   subtype I8 is Interfaces.Integer_8;
   subtype I16 is Interfaces.Integer_16;
   subtype I32 is Interfaces.Integer_32;
   subtype I64 is Interfaces.Integer_64;
   subtype I128 is Interfaces.Integer_128;

   type Bytes is array (Positive range <>) of aliased U8
   with Independent_Components;
end Rand_Core;
