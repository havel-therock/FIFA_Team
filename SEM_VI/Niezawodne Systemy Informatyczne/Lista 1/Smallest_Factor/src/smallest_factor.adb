package body Smallest_Factor with SPARK_Mode is
   procedure Smallest_Factor (N : in out Positive; Factor : out Positive) is
     
      pragma Assert( N > 1 );
   begin
      Factor := N;
      for  J in 2 .. Factor loop
         if N rem J /= 0  then
            null;
         else
            Factor := J;
            N := N / Factor;
            pragma Assert (Factor > 1); 
            exit;
         end if;
      end loop;
   end Smallest_Factor;
end Smallest_Factor;
