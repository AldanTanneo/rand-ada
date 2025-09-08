pragma Warnings (Off);
with Ada.Assertions; use Ada.Assertions;
--  Make Assert visible to children
pragma Warnings (On);

with Rand;

package Tests is
   function Parse_Hex_String (S : String) return Rand.Core.Bytes;
end Tests;
