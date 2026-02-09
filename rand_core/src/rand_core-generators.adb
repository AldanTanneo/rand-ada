with Ada.Unchecked_Conversion;

with Rand_Core.Utils;

package body Rand_Core.Generators
  with Pure
is
   function Gen (R : in out Rng'Class) return Float
   is (Float'Compose
         (Float (Utils.Shr (R.Next, 64 - Float'Machine_Mantissa)), 1)
       - 1.0);
   function Gen (R : in out Rng'Class) return Long_Float
   is (Long_Float'Compose
         (Long_Float (Utils.Shr (R.Next, 64 - Long_Float'Machine_Mantissa)), 1)
       - 1.0);

   function U32_To_Int is new Ada.Unchecked_Conversion (U32, Integer);
   function U64_To_Int is new Ada.Unchecked_Conversion (U64, Long_Integer);

   function Gen (R : in out Rng'Class) return Integer
   is (U32_To_Int (R.Gen));
   function Gen (R : in out Rng'Class) return Long_Integer
   is (U64_To_Int (R.Gen));

   function U8_To_I8 is new Ada.Unchecked_Conversion (U8, I8);
   function U16_To_I16 is new Ada.Unchecked_Conversion (U16, I16);
   function U32_To_I32 is new Ada.Unchecked_Conversion (U32, I32);
   function U64_To_I64 is new Ada.Unchecked_Conversion (U64, I64);
   function U128_To_I128 is new Ada.Unchecked_Conversion (U128, I128);

   function Gen (R : in out Rng'Class) return I8
   is (U8_To_I8 (R.Gen));
   function Gen (R : in out Rng'Class) return I16
   is (U16_To_I16 (R.Gen));
   function Gen (R : in out Rng'Class) return I32
   is (U32_To_I32 (R.Gen));
   function Gen (R : in out Rng'Class) return I64
   is (U64_To_I64 (R.Gen));
   function Gen (R : in out Rng'Class) return I128
   is (U128_To_I128 (R.Gen));

   function Gen (R : in out Rng'Class) return U8
   is (U8 (Utils.Shr (R.Next, 56)));
   function Gen (R : in out Rng'Class) return U16
   is (U16 (Utils.Shr (R.Next, 48)));
   function Gen (R : in out Rng'Class) return U32
   is (U32 (Utils.Shr (R.Next, 32)));
   function Gen (R : in out Rng'Class) return U64
   is (R.Next);
   use type U128;
   function Gen (R : in out Rng'Class) return U128
   is (U128 (R.Next) or Utils.Shl (U128 (R.Next), 64));
end Rand_Core.Generators;
