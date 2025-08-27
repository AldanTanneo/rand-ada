with Rand.Thread_Local;
pragma Elaborate (Rand.Thread_Local);

package body Rand is
   function Thread_Rng return Rng'Class
   is (Rand.Thread_Local.Get);
end Rand;
