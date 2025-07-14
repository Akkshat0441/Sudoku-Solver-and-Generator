module automatic test;
  function void run;
    my_item item = new();
    for (int i = 0; i < 1; i++) begin
      $display("RANDOMIZE %0d", i);
      if (item.randomize()) begin
        item.print();
      end else begin
        $display("Failed to randomize.");
      end
    end
  endfunction: run

  initial begin
    run();
    $finish;
  end

endmodule: test
