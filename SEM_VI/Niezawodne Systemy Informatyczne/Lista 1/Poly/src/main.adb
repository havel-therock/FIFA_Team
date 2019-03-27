with Ada.Integer_Text_IO; USE Integer_Text_IO;
with Poly;
procedure Main is
   X: Integer:=5;
   Y: Poly.Vector:= (6,4,8);
begin
   Put( Poly.Horner(X => X,
                    A => Y ));
end Main;
