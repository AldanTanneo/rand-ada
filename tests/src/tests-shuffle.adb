with Rand.Sequence;
with Ada.Text_IO;

procedure Tests.Shuffle is
   type Idx is range 1 .. 100;
   type Elt is (A, B, C, D, E, F);
   pragma Unreferenced (A, B, C, D, E, F);
   type Seq is array (Idx range <>) of Elt;

   procedure S is new Rand.Sequence.Shuffle (Idx, Elt, Seq, Rand.Rng);

   Slice : Seq := [for I in 1 .. 24 => Elt'Enum_Val ((I - 1) mod 6)];
   R     : Rand.Rng := Rand.Thread_Rng;

   type Counts_Array is array (Elt) of Natural;
   Counts : Counts_Array := [others => 0];
begin
   Ada.Text_IO.Put_Line (Slice'Img);
   S (Slice, R);

   for E of Slice loop
      Counts (E) := Counts (E) + 1;
   end loop;
   Assert
     ((for all Count of Counts => Count = 4),
      "missing elements after shuffle");

   Ada.Text_IO.Put_Line (Slice'Img);
end Tests.Shuffle;
