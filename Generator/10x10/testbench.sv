module automatic test_sudoku_generator_10x10;
  function void run();
    sudoku_generator_10x10 generator = new();
    if (generator.randomize()) begin
      generator.generate_playable_puzzle();
      $display("\nPlayable Sudoku Puzzle:");
      generator.print();
    end else begin
      $display("Failed to randomize Sudoku.");
    end
  endfunction

  initial begin
    run();
    $finish;
  end
endmodule
