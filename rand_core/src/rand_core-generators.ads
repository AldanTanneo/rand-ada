package Rand_Core.Generators is
   type Rng is limited interface;

   function Next (R : in out Rng) return U64 is abstract;
   procedure Next_Bytes (R : in out Rng; Buf : out Bytes) is abstract;
end Rand_Core.Generators;
