with Rand_Core.Utils;

with System_Random;

package body Rand_Sys
  with Preelaborate
is

   function Get return OS_Rng is
      R : OS_Rng;
   begin
      return R;
   end Get;

   package System_Rng is new System_Random (U8, Positive, Bytes);

   procedure Next_Bytes (R : in out OS_Rng; Buf : out Bytes) is
      Max_Len : constant := 256;

      Res  : aliased Bytes := (1 .. Max_Len => 0);
      Full : constant Natural := Buf'Length / Max_Len;
      Curr : Natural := Buf'First - 1;
   begin
      for I in 1 .. Full loop
         System_Rng.Random (Res);
         Buf (Curr + 1 .. Curr + Max_Len) := Res;
         Curr := Curr + Max_Len;
      end loop;
      if Curr < Buf'Last then
         System_Rng.Random (Res);
         Buf (Curr + 1 .. Buf'Last) := Res (1 .. Buf'Last - Curr);
      end if;
   end Next_Bytes;

   function Next_Impl is new Generators.Generic_Next (OS_Rng);
   function Next (R : in out OS_Rng) return U64 renames Next_Impl;

end Rand_Sys;
