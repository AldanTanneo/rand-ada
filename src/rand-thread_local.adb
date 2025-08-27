with Rand_Chacha;
with Rand_Sys;

package body Rand.Thread_Local is
   package ChaCha renames Rand_Chacha;

   Thread_Local_Rng : access ChaCha.ChaCha_Rng := null
   with Thread_Local_Storage;

   function Get return Thread_Rng is
      R : Rand_Sys.OS_Rng := Rand_Sys.Get;
   begin
      if Thread_Local_Rng = null then
         --  safe because no other thread can access this during
         --  initialisation
         Thread_Local_Rng :=
           new ChaCha.ChaCha_Rng'(ChaCha.From_Rng (R, ChaCha.ChaCha12));
      end if;
      return Res : Thread_Rng;
   end Get;

   --  forward calls to the chacha rng

   function Next (R : in out Thread_Rng) return Core.U64
   is (Thread_Local_Rng.Next);

   procedure Next_Bytes (R : in out Thread_Rng; Buf : out Bytes) is
   begin
      Thread_Local_Rng.Next_Bytes (Buf);
   end Next_Bytes;

end Rand.Thread_Local;
