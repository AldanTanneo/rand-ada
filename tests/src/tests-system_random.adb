with Rand_Sys;

procedure Tests.System_Random is
   use Rand.Core;
   use type U64;
   use type U8;

   R : Rand_Sys.OS_Rng := Rand_Sys.Get;

   X : constant U64 := R.Next;
   Y : constant U64 := R.Next;

   Buf : Bytes (1 .. 512);
begin
   Assert (X /= 0, "system randomness should be different from 0");
   Assert (X /= Y, "system randomness should give distinct elements");

   R.Next_Bytes (Buf);
   Assert
     ((for some B of Buf => B /= 0),
      "system randomness should have a non-null byte");
end Tests.System_Random;
