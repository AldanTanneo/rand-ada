package Rand_Core.Generators is
   type Rng is limited interface;

   function Next (R : in out Rng) return U64 is abstract;
   procedure Next_Bytes (R : in out Rng; Buf : out Bytes) is abstract;

   function Gen (R : in out Rng'Class) return Float
   with Inline_Always;
   function Gen (R : in out Rng'Class) return Long_Float
   with Inline_Always;
   function Gen (R : in out Rng'Class) return Integer
   with Inline_Always;
   function Gen (R : in out Rng'Class) return Long_Integer
   with Inline_Always;

   function Gen (R : in out Rng'Class) return I8
   with Inline_Always;
   function Gen (R : in out Rng'Class) return I16
   with Inline_Always;
   function Gen (R : in out Rng'Class) return I32
   with Inline_Always;
   function Gen (R : in out Rng'Class) return I64
   with Inline_Always;
   function Gen (R : in out Rng'Class) return I128
   with Inline_Always;

   function Gen (R : in out Rng'Class) return U8
   with Inline_Always;
   function Gen (R : in out Rng'Class) return U16
   with Inline_Always;
   function Gen (R : in out Rng'Class) return U32
   with Inline_Always;
   function Gen (R : in out Rng'Class) return U64
   with Inline_Always;
   function Gen (R : in out Rng'Class) return U128
   with Inline_Always;
end Rand_Core.Generators;
