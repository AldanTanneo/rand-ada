with Rand_Core.Utils;

with System_Random;

package body Rand_Sys is

   function Get return OS_Rng is
      R : OS_Rng;
   begin
      return R;
   end Get;

   package System_Rng is new System_Random (U8, Positive, Bytes);

   procedure Next_Bytes (R : in out OS_Rng; Buf : out Bytes) is
      Max_Len : constant := 256;

      Res  : aliased Bytes := (1 .. 256 => 0);
      Full : constant Natural := Buf'Length / Max_Len;
      Curr : Natural := Buf'First - 1;
   begin
      for I in 1 .. Full loop
         System_Rng.Random (Res);
         Buf (Curr + 1 .. Curr + Max_Len) := Res;
         Curr := Curr + 256;
      end loop;
      if Curr < Buf'Last then
         System_Rng.Random (Res);
         Buf (Curr + 1 .. Buf'Last) := Res (1 .. Buf'Last - Curr);
      end if;
   end Next_Bytes;

   function Next (R : in out OS_Rng) return U64 is
      Buf : Utils.Bytes8;
   begin
      Next_Bytes (R, Buf);
      return Utils.From_NE_Bytes (Buf);
   end Next;

end Rand_Sys;
