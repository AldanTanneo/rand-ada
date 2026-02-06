with GNAT.Source_Info;
with Rand;

package Tests is
   function Is_Hex (C : Character) return Boolean
   is (C in '0' .. '9' | 'a' .. 'f' | 'A' .. 'F');

   subtype Hex_String is String
   with
     Predicate =>
       Hex_String'Length mod 2 = 0
       and then (for all C of Hex_String => Is_Hex (C));

   function Parse_Hex_String (S : Hex_String) return Rand.Core.Bytes;

   function To_Hex_String (Buf : Rand.Core.Bytes) return Hex_String;

   procedure Assert
     (Condition : Boolean;
      Message   : String := "assertion failed";
      Source    : String := GNAT.Source_Info.Source_Location);
   --  custom assertion procedure, with message and source tracing.
end Tests;
