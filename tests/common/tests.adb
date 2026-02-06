with Ada.Assertions;
with Ada.Environment_Variables;
with Ada.Text_IO;

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

   function To_Hex_String (Buf : Rand.Core.Bytes) return Hex_String is
      use type Rand.Core.U8;
      S : String (1 .. Buf'Length * 2);
      function Byte_To_Char (B : Rand.Core.U8) return Character
      with Pre => B in 0 .. 15
      is
      begin
         case B is
            when 0 .. 9   =>
               return Character'Val (B + Character'Pos ('0'));

            when 10 .. 15 =>
               return Character'Val (B - 10 + Character'Pos ('a'));

            when others   =>
               raise Program_Error with "unreachable";
         end case;
      end Byte_To_Char;
   begin
      for I in Buf'Range loop
         S (I * 2 - 1) := Byte_To_Char (Buf (I) / 16);
         S (I * 2) := Byte_To_Char (Buf (I) mod 16);
      end loop;
      return S;
   end To_Hex_String;

   Alire_Tests_Path : constant String :=
     Ada.Environment_Variables.Value ("ALIRE_TESTS_PATH", "");
   --  set in VSCode custom task. Allows VSCode diagnostics to work.

   procedure Assert
     (Condition : Boolean;
      Message   : String := "assertion failed";
      Source    : String := GNAT.Source_Info.Source_Location) is
   begin
      if not Condition then
         Ada.Text_IO.Put_Line
           (Ada.Text_IO.Standard_Error,
            Alire_Tests_Path
            & Source
            & ":"
            & (if Alire_Tests_Path /= "" then "0:" else "")
            & " error: "
            & Message);
         raise Ada.Assertions.Assertion_Error;
      end if;
   end Assert;
end Tests;
