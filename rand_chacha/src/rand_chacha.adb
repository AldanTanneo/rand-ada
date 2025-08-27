with Ada.Unchecked_Conversion;
with Rand_Core.Utils; use Rand_Core.Utils;

package body Rand_Chacha is
   use all type U32;
   type Chars4 is array (1 .. 4) of Character;

   function Convert is new
     Ada.Unchecked_Conversion (Source => Chars4, Target => Bytes4);

   function U32_Bytes (C : Chars4) return U32
   is (From_LE_Bytes (Convert (C)))
   with Inline_Always;

   C0 : constant U32 := U32_Bytes ("expa");
   C1 : constant U32 := U32_Bytes ("nd 3");
   C2 : constant U32 := U32_Bytes ("2-by");
   C3 : constant U32 := U32_Bytes ("te k");

   function Create_Seeded
     (Key : Seed_Type; Kind : ChaCha_Kind := ChaCha12) return ChaCha_Rng is
   begin
      return R : ChaCha_Rng (Kind) do
         R.State (0 .. 3) := (C0, C1, C2, C3);

         for I in 4 .. 11 loop
            R.State (I) :=
              From_LE_Bytes (Key (4 * (I - 4) + 1 .. 4 * (I - 3)));
         end loop;

         R.State (12 .. 15) := (0, 0, 0, 0);

         R.Current := (others => 0);
         R.Current_Pos := State_Byte_Range'Last + 1;
      end return;
   end Create_Seeded;

   function From_Rng
     (R : in out Generators.Rng'Class; Kind : ChaCha_Kind := ChaCha12)
      return ChaCha_Rng
   is
      S : Seed_Type;
   begin
      R.Next_Bytes (S);
      return Create_Seeded (S, Kind);
   end From_Rng;

   function Num_Double_Rounds (R : ChaCha_Rng) return Positive
   is (case R.Kind is
         when ChaCha8 => 4,
         when ChaCha12 => 6,
         when ChaCha20 => 10)
   with Inline_Always;

   procedure Do_Rounds (R : in out ChaCha_Rng) is
      Result : State_Array := R.State;

      procedure Quarter_Round (I, J, K, L : State_Range) with Inline is
         A : U32 := Result (I);
         B : U32 := Result (J);
         C : U32 := Result (K);
         D : U32 := Result (L);
      begin
         A := A + B;
         D := Rotl (D xor A, 16);

         C := C + D;
         B := Rotl (B xor C, 12);

         A := A + B;
         D := Rotl (D xor A, 8);

         C := C + D;
         B := Rotl (B xor C, 7);

         Result (I) := A;
         Result (J) := B;
         Result (K) := C;
         Result (L) := D;
      end Quarter_Round;

      procedure Double_Round with Inline is
      begin
         Quarter_Round (0, 4, 8, 12);
         Quarter_Round (1, 5, 9, 13);
         Quarter_Round (2, 6, 10, 14);
         Quarter_Round (3, 7, 11, 15);

         Quarter_Round (0, 5, 10, 15);
         Quarter_Round (1, 6, 11, 12);
         Quarter_Round (2, 7, 8, 13);
         Quarter_Round (3, 4, 9, 14);
      end Double_Round;

      function Convert is new
        Ada.Unchecked_Conversion
          (Source => State_Array,
           Target => State_Bytes);
   begin
      for I in 1 .. Num_Double_Rounds (R) loop
         Double_Round;
      end loop;

      for I in Result'Range loop
         Result (I) := Result (I) + R.State (I);
      end loop;

      R.State (12) := R.State (12) + 1; --  increment counter
      R.Current := Convert (Result);
      R.Current_Pos := 1;
   end Do_Rounds;

   procedure Next_Bytes (R : in out ChaCha_Rng; Buf : out Bytes) is
      Pos : Natural := Buf'First - 1;

      Diff : Positive;
   begin
      while Pos < Buf'Last loop
         if R.Current_Pos not in State_Byte_Range then
            R.Do_Rounds;
         end if;

         Diff :=
           Positive'Min
             (Buf'Last - Pos, State_Byte_Range'Last + 1 - R.Current_Pos);
         Buf (Pos + 1 .. Pos + Diff) :=
           R.Current (R.Current_Pos .. R.Current_Pos + Diff - 1);

         R.Current_Pos := R.Current_Pos + Diff;
         Pos := Pos + Diff;
      end loop;
   end Next_Bytes;

   function Next (R : in out ChaCha_Rng) return U64 is
      Buf : Bytes8;
   begin
      R.Next_Bytes (Buf);
      return From_LE_Bytes (Buf);
   end Next;
end Rand_Chacha;
