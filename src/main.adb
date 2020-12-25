with Ada.Text_IO; use Ada.Text_IO;

procedure Main is

   size: Integer := 50000;
   num_of_threads: Integer := 4;
   num_of_thread_elements: Integer := size / num_of_threads;
   type my_arr is array(0..size-1) of Long_Integer;

   protected sum_resolver is
      procedure find_part_sum(arr: my_arr; num_of_thread: Integer);
      procedure save_part_sum;
      function get_sum return Long_Integer;
   private
      part_sum: Long_Integer := 0;
      sum: Long_Integer := 0;
      array_begin: Integer := 0;
      array_end: Integer := 0;
   end sum_resolver;

protected body sum_resolver is

      procedure find_part_sum(arr: my_arr; num_of_thread: Integer) is
      begin
         array_begin := num_of_thread * num_of_thread_elements;
         array_end := (num_of_thread + 1) * num_of_thread_elements - 1;

         for i in array_begin..array_end loop
            part_sum := part_sum + arr(i);
         end loop;
      end;

      procedure save_part_sum is
      begin
         sum := sum + part_sum;
         part_sum := 0;
      end;

      function get_sum return Long_Integer is
      begin
         return sum;
      end;

   end sum_resolver;

   arr: my_arr;
begin

   for i in 0..size-1 loop
      arr(i) := long_integer(i);
   end loop;

  for i in 0..3 loop
      sum_resolver.find_part_sum(arr, i);
      sum_resolver.save_part_sum;
   end loop;

   Put_Line(sum_resolver.get_sum'Img);
end Main;

