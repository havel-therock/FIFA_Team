with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
with Smallest_Factor;
procedure Main is
   N: Positive :=13;
   X: Positive;
begin
   Smallest_Factor.Smallest_Factor(N      => N,
                                   Factor => X);
   Put (X);
end Main;
