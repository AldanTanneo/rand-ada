with Rand.Thread_Local;
pragma Elaborate (Rand.Thread_Local);

package body Rand is
   function Thread_Rng return Rng
   is (Rand.Thread_Local.Get);

   function Small_Rng return Rng is
      R : Sys.OS_Rng := Sys.Get;
   begin
      return Xoshiro256.From_Rng (R);
   end Small_Rng;
end Rand;
