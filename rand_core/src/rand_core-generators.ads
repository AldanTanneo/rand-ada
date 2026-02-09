package Rand_Core.Generators
  with Pure
is
   type Rng is limited interface;
   --  Interface for a random number generator

   function Next (R : in out Rng) return U64 is abstract;
   --  Update the generator state and output the next 64-bit value
   procedure Next_Bytes (R : in out Rng; Buf : out Bytes) is abstract;
   --  Update the generator state and fill the provided buffer with random
   --  bytes

   --
   --  utility functions for generating standard types
   --

   generic
      type F is digits <>;
      pragma
        Compile_Time_Error
          (F'Machine_Mantissa > 64, "type mantissa must be <=64");
   function Generic_Float (R : in out Rng'Class) return F
   with Inline;
   --  Generic function to generate a floating point value in the range [0, 1)

   function Gen (R : in out Rng'Class) return Float
   with Inline_Always;
   --  Return a Float in [0, 1)
   function Gen (R : in out Rng'Class) return Long_Float
   with Inline_Always;
   --  Return a Long_Float in [0, 1)
   function Gen (R : in out Rng'Class) return Integer
   with Inline_Always;
   --  Return a random Integer over the whole range
   function Gen (R : in out Rng'Class) return Long_Integer
   with Inline_Always;
   --  Return a random Long_Integer over the whole range

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
