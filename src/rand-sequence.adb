with Rand_Distributions.Uniform;
pragma Extensions_Allowed (All_Extensions);

package body Rand.Sequence
  with Preelaborate
is
   procedure Shuffle (S : in out Seq; R : in out Rng) is
      package Distr is new Rand_Distributions.Generic_Distribution (Idx);
      package Uniform is new Rand_Distributions.Uniform.Discrete (Idx, Distr);
      function Sample_Impl is new Uniform.Sample_Generic (Rng);

      Tmp : Elt;
      J   : Idx;
      U   : Uniform.Distribution;
   begin
      for I in S'First .. Idx'Pred (S'Last) loop
         U := Uniform.Create (I, S'Last);
         J := Sample_Impl (U, R);

         Tmp := S (I);
         S (I) := S (J);
         S (J) := Tmp;
      end loop;
   end Shuffle;

   procedure Constrained_Shuffle (S : in out Seq; R : in out Rng) is
      package Distr is new Rand_Distributions.Generic_Distribution (Idx);
      package Uniform is new Rand_Distributions.Uniform.Discrete (Idx, Distr);
      function Sample_Impl is new Uniform.Sample_Generic (Rng);

      Tmp : Elt;
      J   : Idx;
      U   : Uniform.Distribution;
   begin
      for I in S'First .. Idx'Pred (S'Last) loop
         U := Uniform.Create (I, S'Last);
         J := Sample_Impl (U, R);

         Tmp := S (I);
         S (I) := S (J);
         S (J) := Tmp;
      end loop;
   end Constrained_Shuffle;
end Rand.Sequence;
