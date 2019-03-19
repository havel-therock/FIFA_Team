package Smallest_Factor with SPARK_Mode is

   procedure Smallest_Factor (N : in out Positive; Factor : out Positive)
     with
       Pre => N > 1,
       Post => (Factor > 1) and
     (N'Old / Factor = N) and
     (N'Old rem Factor = 0) and
     (for all J in 2 .. Factor - 1 => N'Old rem J /= 0);

end Smallest_Factor;
