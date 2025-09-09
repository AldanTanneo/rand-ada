with Rand_Sys;

procedure Tests.System_Random is
   use Rand.Core;
   use all type U64;

   R : Rand_Sys.OS_Rng := Rand_Sys.Get;

   X : constant U64 := R.Next;
   Y : constant U64 := R.Next;
begin
   Assert (X /= 0);
   Assert (X /= Y);
end Tests.System_Random;
