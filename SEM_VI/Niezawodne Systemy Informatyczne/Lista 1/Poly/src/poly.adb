package body Poly with SPARK_Mode is
   function Horner (X: Integer; A : Vector) return Integer is
      Y : Integer := 0;
   begin       
      for I in A'Range loop
         Y := (Y*X) + A(A'First + I);
      end loop;
      return Y;
   end Horner ;
end Poly;
