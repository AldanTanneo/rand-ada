with Rand; use Rand;
with Rand_Distributions.Uniform;

procedure Tests.Uniform_Enum is
   type T is (A, B, C, D, E, F);

   package T_Distr is new Rand_Distributions.Generic_Distribution (T);
   package T_Uniform is new Rand_Distributions.Uniform.Discrete (T, T_Distr);

   R  : Rng := Thread_Rng;
   U1 : constant T_Uniform.Distribution := T_Uniform.Create;
   U2 : constant T_Uniform.Distribution := T_Uniform.Create (B, E);
begin
   for I in 1 .. 1000000 loop
      Assert (U1.Sample (R) in T, "invalid enum member");
      Assert (U2.Sample (R) in B .. E, "enum member not in required range");
   end loop;
end Tests.Uniform_Enum;
