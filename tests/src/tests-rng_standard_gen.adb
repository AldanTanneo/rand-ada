with Rand; use Rand;

procedure Tests.Rng_Standard_Gen is
   R : Rng := Thread_Rng;

   F   : Float;
   Lf  : Long_Float;
   Llf : Long_Long_Float;

   I    : Integer;
   Li   : Long_Integer;
   Lli  : Long_Long_Integer;
   Llli : Long_Long_Long_Integer;

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
   for X in 1 .. 1000000 loop
      F := R.Gen;
      Assert (F >= 0.0 and then F < 1.0, "Float not in [0, 1)");
      Lf := R.Gen;
      Assert (Lf >= 0.0 and then Lf < 1.0, "Long_Float not in [0, 1)");
      Llf := R.Gen;
      Assert (Llf >= 0.0 and then Llf < 1.0, "Long_Long_Float not in [0, 1)");

      I := R.Gen;
      Assert (I'Valid, "invalid Integer");
      Li := R.Gen;
      Assert (Li'Valid, "invalid Long_Integer");
      Lli := R.Gen;
      Assert (Lli'Valid, "invalid Long_Long_Integer");
      Llli := R.Gen;
      Assert (Llli'Valid, "invalid Long_Long_Long_Integer");

      I8 := R.Gen;
      Assert (I8'Valid, "invalid I8");
      I16 := R.Gen;
      Assert (I16'Valid, "invalid I16");
      I32 := R.Gen;
      Assert (I32'Valid, "invalid I32");
      I64 := R.Gen;
      Assert (I64'Valid, "invalid I64");
      I128 := R.Gen;
      Assert (I128'Valid, "invalid I128");

      U8 := R.Gen;
      Assert (U8'Valid, "invalid U8");
      U16 := R.Gen;
      Assert (U16'Valid, "invalid U16");
      U32 := R.Gen;
      Assert (U32'Valid, "invalid U32");
      U64 := R.Gen;
      Assert (U64'Valid, "invalid U64");
      U128 := R.Gen;
      Assert (U128'Valid, "invalid U128");
   end loop;
end Tests.Rng_Standard_Gen;
