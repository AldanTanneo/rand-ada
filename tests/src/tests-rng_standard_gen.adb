with Rand; use Rand;

procedure Tests.Rng_Standard_Gen is
   R : Rng := Thread_Rng;

   F  : Float;
   Lf : Long_Float;

   I  : Integer;
   Li : Long_Integer;

   I8   : Core.I8;
   I16  : Core.I16;
   I32  : Core.I32;
   I64  : Core.I64;
   I128 : Core.I128;

   U8   : Core.U8;
   U16  : Core.U16;
   U32  : Core.U32;
   U64  : Core.U64;
   U128 : Core.U128;
begin
   for X in 1 .. 100000 loop
      F := R.Gen;
      Assert (F in 0.0 .. 1.0);
      Lf := R.Gen;
      Assert (Lf in 0.0 .. 1.0);

      I := R.Gen;
      Assert (I'Valid);
      Li := R.Gen;
      Assert (Li'Valid);

      I8 := R.Gen;
      Assert (I8'Valid);
      I16 := R.Gen;
      Assert (I16'Valid);
      I32 := R.Gen;
      Assert (I32'Valid);
      I64 := R.Gen;
      Assert (I64'Valid);
      I128 := R.Gen;
      Assert (I128'Valid);

      U8 := R.Gen;
      Assert (U8'Valid);
      U16 := R.Gen;
      Assert (U16'Valid);
      U32 := R.Gen;
      Assert (U32'Valid);
      U64 := R.Gen;
      Assert (U64'Valid);
      U128 := R.Gen;
      Assert (U128'Valid);
   end loop;
end Tests.Rng_Standard_Gen;
