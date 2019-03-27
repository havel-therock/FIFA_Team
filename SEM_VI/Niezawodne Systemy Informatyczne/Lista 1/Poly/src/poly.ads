package Poly with SPARK_Mode Is
   type Vector is array (Natural range <>) of Integer;
   function Horner (X : Integer; A : Vector) return Integer with
     Pre => A'Length > 0 and A'Last < Integer'Last;
end Poly;
