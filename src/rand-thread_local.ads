--  Provides a secure, thread local random generator.
--  Implementation may be subject to change.

package Rand.Thread_Local is
   type Thread_Rng (<>) is new Rng with private;

   overriding
   function Next (R : in out Thread_Rng) return Core.U64
   with Inline;
   overriding
   procedure Next_Bytes (R : in out Thread_Rng; Buf : out Bytes)
   with Inline;

   function Get return Thread_Rng
   with Inline;

private
   type Thread_Rng is new Rng with null record;
end Rand.Thread_Local;
