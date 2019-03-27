package body Find with SPARK_Mode is

   function Max (V : Vector) return Integer is
      M : Integer := V(V'First);
   begin
      for I in V'First + 1 .. V'Last loop
         pragma Loop_Invariant (for all J in V'First .. I - 1 =>
                                  V(J) <= M);
         pragma Loop_Invariant (for some J in V'First .. I - 1 =>
                                  V(J) = M);
         if V(I) > M then
            M := V(I);
         end if;
      end loop;
      return M;
   end Max;

end Find;
