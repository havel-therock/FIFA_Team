package body selection is
  
   procedure Sort (A : in out Arr) with SPARK_Mode is 
      Min  : Integer;
      Temp : Integer;
   begin
      for I in A'First..(A'Last - 1) loop
         Min := I;
         for J in I + 1..A'Last loop
            if A (Min) > A (J) then
               Min := J;
            end if;
         end loop;
         if Min /= I then
            Temp    := A (I);
            A (I)   := A (Min);
            A (Min) := Temp;
         end if;
      end loop;
   end Sort;

end selection;
