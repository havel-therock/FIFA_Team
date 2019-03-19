package Find with SPARK_Mode is

   type Vector is array (Integer range <>) of Integer;

   function Max (V : Vector) return Integer
     with
       Pre =>
         V'Length > 0 and V'First < Integer'Last,
       Post =>
         (for all I in V'Range => V(I) <= Max'Result) and
         (for some I in V'Range => V(I) = Max'Result);

end Find;
