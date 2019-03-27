with Ada.Text_IO; use Ada.Text_IO;
with Selection;
procedure Main is
   A:Selection.Arr:= (2,6,4,3,8,5,9);

begin
    for I in A'Range loop
      Put (Integer'Image (A (I)) & " ");
   end loop;
   Selection.Sort(A => A);
   Put_Line("");
    for I in A'Range loop
      Put (Integer'Image (A (I)) & " ");
   end loop;
end Main;
