package Rand.Sequence
  with Preelaborate
is
   generic
      type Idx is (<>);
      type Elt is private;
      type Seq is array (Idx range <>) of Elt;
      type Rng (<>) is limited new Core_Rng with private;
   procedure Shuffle (S : in out Seq; R : in out Rng);
   --  Generic procedure to shuffle an array

   generic
      type Idx is (<>);
      type Elt is private;
      type Seq is array (Idx) of Elt;
      type Rng (<>) is limited new Core_Rng with private;
   procedure Constrained_Shuffle (S : in out Seq; R : in out Rng);
   --  Generic procedure to shuffle a constrained array
end Rand.Sequence;
