with Rand; use Rand;
-- with Ada.Text_IO;

procedure Tests.ChaCha20 is
   use all type Bytes;

   type Seed_Array is array (Positive range <>) of ChaCha.Seed_Type;
   type Keystream_Array is array (Positive range <>) of Bytes (1 .. 60);

   -- array of test keys

   Keys : constant Seed_Array :=
     [[others => 0], -- all zeros
      [ChaCha.Seed_Type'Last => 1, others => 0], -- all zeros except last
      [for I in ChaCha.Seed_Type'Range => Core.U8 (I - 1)], -- increasing
      -- randomly generated
      Parse_Hex_String
        ("99979bcd97601e0f80159b8ba648e33f05dd7e5fa60662d99b90b159fc46d29b")];

   -- expected keystreams from test keys

   Expected : constant Keystream_Array :=
     [Parse_Hex_String
        ("76b8e0ada0f13d90405d6ae55386bd28bdd219b8a08ded1aa836efcc8b77"
         & "0dc7da41597c5157488d7724e03fb8d84a376a43b8f41518a11cc387b669"),
      Parse_Hex_String
        ("4540f05a9f1fb296d7736e7b208e3c96eb4fe1834688d2604f450952ed43"
         & "2d41bbe2a0b6ea7566d2a5d1e7e20d42af2c53d792b1c43fea817e9ad275"),
      Parse_Hex_String
        ("39fd2b7dd9c5196a8dbd0377b8dc4a498a35d86fbcde6accb2cc7d4cd8ea"
         & "24922b23cce7a26023ab3f0eef693ac87f64258235eab1f7a32dc22762a0"),
      Parse_Hex_String
        ("bd3b5f67653ae96dd514ec2f2ee396c010220c5dc53e6e166d9d072961ef"
         & "49b09f15f73d2dcd879837b11c2a55e10afd602c533c25d48df034396f35")];
begin
   for I in Keys'Range loop
      declare
         Buf : Bytes (1 .. 60);
         R   : Rng'Class := ChaCha.Create_Seeded (Keys (I), ChaCha.ChaCha20);
      begin
         R.Next_Bytes (Buf);
         -- Ada.Text_IO.Put_Line ("Got : " & Buf'Image);
         -- Ada.Text_IO.Put_Line ("Exp : " & Expected (I)'Image);
         Assert (Buf = Expected (I));
      end;
   end loop;
end Tests.ChaCha20;
