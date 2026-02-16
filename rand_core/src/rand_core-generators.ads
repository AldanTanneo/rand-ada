--  A common interface type for pseudo-random number generators, or PRNGs.
--  It requires the user to implement the `Next` and `Next_Bytes` subprograms.
--  
--  `Next` outputs U64 values, and `Next_Bytes` fills an array of
--  bytes given as an `out` parameter. If your generator naturally corresponds
--  to only one of those two modes, you can use the provided `Generic_Next` and
--  `Generic_Next_Bytes` to implement the other one in a standard way.
--
--  It is also recommended to implement a secure constructor named `From_Rng`,
--  which takes an instance of another PRNG and properly seeds the generator.
--  This is useful (and necessary in security-sensitive contexts) for seeding
--  the generator using system entropy.
--
--  This package also provides some utility methods on the Rng classwide type
--  for generating basic types, as well as generic methods for generating
--  floating point and integer values.

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

   generic
      type Rg (<>) is limited new Rng with private;
   function Generic_Next (R : in out Rg) return U64;
   --  Generic implementation of Next when Next_Bytes is provided

   generic
      type Rg (<>) is limited new Rng with private;
   procedure Generic_Next_Bytes (R : in out Rg; Buf : out Bytes);
   --  Generic implementation of Next_Bytes when Next is provided

   --
   --  utility functions for generating standard types
   --

   function Gen (R : in out Rng'Class) return Boolean
   with Inline_Always;
   --  Return a Boolean with equal probability

   generic
      type F is digits <>;
      type Rg (<>) is limited new Rng with private;
      pragma
        Compile_Time_Error
          (F'Machine_Mantissa > 64, "type mantissa must be <=64");
   function Generic_Float (R : in out Rg) return F
   with Inline;
   --  Generic function to generate a floating point value in the range [0, 1)

   function Gen (R : in out Rng'Class) return Short_Float
   with Inline_Always;
   --  Return a Short_Float in [0, 1)
   function Gen (R : in out Rng'Class) return Float
   with Inline_Always;
   --  Return a Float in [0, 1)
   function Gen (R : in out Rng'Class) return Long_Float
   with Inline_Always;
   --  Return a Long_Float in [0, 1)
   function Gen (R : in out Rng'Class) return Long_Long_Float
   with Inline_Always;
   --  Return a Long_Long_Float in [0, 1)

   generic
      type I is range <>;
      type Rg (<>) is limited new Rng with private;
      pragma
        Compile_Time_Error
          (not (I'Size = 8
                or else I'Size = 16
                or else I'Size = 32
                or else I'Size = 64
                or else I'Size = 128),
           "unsupported integer size");
   function Generic_Integer (R : in out Rg) return I
   with Inline;
   --  Generic function to generate an integer value over the whole machine
   --  range. Only supports sizes 8, 16, 32, 64 and 128. Do not use with
   --  integer types that have a restricted range.

   function Gen (R : in out Rng'Class) return Short_Short_Integer
   with Inline_Always;
   --  Return a random Short_Short_Integer over the whole range
   function Gen (R : in out Rng'Class) return Short_Integer
   with Inline_Always;
   --  Return a random Short_Integer over the whole range
   function Gen (R : in out Rng'Class) return Integer
   with Inline_Always;
   --  Return a random Integer over the whole range
   function Gen (R : in out Rng'Class) return Long_Integer
   with Inline_Always;
   --  Return a random Long_Integer over the whole range
   function Gen (R : in out Rng'Class) return Long_Long_Integer
   with Inline_Always;
   --  Return a random Long_Long_Integer over the whole range
   function Gen (R : in out Rng'Class) return Long_Long_Long_Integer
   with Inline_Always;
   --  Return a random Long_Long_Long_Integer over the whole range

   function Gen (R : in out Rng'Class) return I8
   with Inline_Always;
   --  Return a random I8 over the whole range
   function Gen (R : in out Rng'Class) return I16
   with Inline_Always;
   --  Return a random I16 over the whole range
   function Gen (R : in out Rng'Class) return I32
   with Inline_Always;
   --  Return a random I32 over the whole range
   function Gen (R : in out Rng'Class) return I64
   with Inline_Always;
   --  Return a random I64 over the whole range
   function Gen (R : in out Rng'Class) return I128
   with Inline_Always;
   --  Return a random I128 over the whole range

   function Gen (R : in out Rng'Class) return U8
   with Inline_Always;
   --  Return a random U8 over the whole range
   function Gen (R : in out Rng'Class) return U16
   with Inline_Always;
   --  Return a random U16 over the whole range
   function Gen (R : in out Rng'Class) return U32
   with Inline_Always;
   --  Return a random U32 over the whole range
   function Gen (R : in out Rng'Class) return U64
   with Inline_Always;
   --  Return a random U64 over the whole range
   function Gen (R : in out Rng'Class) return U128
   with Inline_Always;
   --  Return a random U128 over the whole range
end Rand_Core.Generators;
