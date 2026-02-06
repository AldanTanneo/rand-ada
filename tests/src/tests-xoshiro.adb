with Rand; use Rand;

procedure Tests.Xoshiro is
   use type Core.U64;

   --!format off
   Gen : Xoshiro256.Xoshiro256_Rng :=
     Xoshiro256.Create_Seeded ([
       1, 0, 0, 0, 0, 0, 0, 0,
       2, 0, 0, 0, 0, 0, 0, 0,
       3, 0, 0, 0, 0, 0, 0, 0,
       4, 0, 0, 0, 0, 0, 0, 0
     ]);

   Expected : constant array (Positive range <>) of Core.U64 := [
       41943041,
       58720359,
       3588806011781223,
       3591011842654386,
       9228616714210784205,
       9973669472204895162,
       14011001112246962877,
       12406186145184390807,
       15849039046786891736,
       10450023813501588000
     ];
   --!format on

   R    : Rng := Thread_Rng;
   Gen2 : Xoshiro256.Xoshiro256_Rng := Xoshiro256.From_Rng (R);

   Gen3 : Xoshiro256.Xoshiro256_Rng :=
     Xoshiro256.Create_Seeded ([others => 0]);

   X : Core.U64;
begin
   for E of Expected loop
      X := Gen.Next;
      Assert
        (X = E,
         "invalid xoshiro output (expected" & E'Img & ", got" & X'Img & ")");
   end loop;

   Assert
     (Gen2.Next /= 0, "system-seeded xoshiro should give non zero output");
   --  check that a system-seeded generator outputs a random value
   Assert (Gen3.Next /= 0, "zero-seeded xoshiro should give non zero output");
   --  check that a zero seeds is properly handled
end Tests.Xoshiro;
