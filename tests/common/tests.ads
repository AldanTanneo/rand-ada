pragma Warnings (Off);
with Ada.Assertions; use Ada.Assertions;
--  Make Assert visible to children
pragma Warnings (On);

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
end Tests;
