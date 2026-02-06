package body Tests is
   use Rand.Core;

   function Parse_Hex_String (S : Hex_String) return Bytes is
      use all type U8;

      function Char_To_Byte (C : Character) return U8 with Pre => Is_Hex (C) is
         function To_U8 (C : Character) return U8
         is (U8 (Character'Pos (C)));
      begin
         case C is
            when '0' .. '9' =>
               return To_U8 (C) - To_U8 ('0');

            when 'a' .. 'f' =>
               return To_U8 (C) - To_U8 ('a') + 10;

            when 'A' .. 'F' =>
               return To_U8 (C) - To_U8 ('A') + 10;

            when others     =>
               raise Program_Error with "unreachable";
         end case;
      end Char_To_Byte;

      Res : Bytes (1 .. S'Length / 2);
   begin
      for I in Res'Range loop
         Res (I) :=
           Char_To_Byte (S (I * 2 - 1)) * 16 + Char_To_Byte (S (I * 2));
      end loop;
      return Res;
   end Parse_Hex_String;

end Tests;
