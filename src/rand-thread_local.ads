--  Provides a secure, thread local random generator.
--  Implementation may be subject to change.

package Rand.Thread_Local is
   type Thread_Rng (<>) is new Core_Rng with private;
   --  Handle to the thread local Rng.

   overriding
   function Next (R : in out Thread_Rng) return Core.U64
   with Inline;
   overriding
   procedure Next_Bytes (R : in out Thread_Rng; Buf : out Core.Bytes)
   with Inline;

   function Get return Thread_Rng
   with Inline;
   --  Get (and initialize if needed) the thread local Rng.

private
   type Thread_Rng is new Core_Rng with null record;
end Rand.Thread_Local;
