`define N 2   // Sub-grid height
`define M 5   // Sub-grid width
`define SIZE 10 // Total grid size (10x10)

class sudoku_generator_10x10;
  rand int puzzle[`SIZE][`SIZE];

  // Constraints to ensure valid Sudoku rules
  constraint valid_sudoku {
    foreach (puzzle[i, j]) {
      foreach (puzzle[ii, jj]) {
        // Ensure no repeated numbers in the same row
        if (ii == i && jj != j) {
          puzzle[i][j] != puzzle[ii][jj];
        }
        // Ensure no repeated numbers in the same column
        if (ii != i && jj == j) {
          puzzle[i][j] != puzzle[ii][jj];
        }
        // Ensure no repeated numbers in the same 2x5 sub-grid
        if ((`M * (ii / `N) + (jj / `M)) == (`M * (i / `N) + (j / `M)) &&
            (i != ii || j != jj)) {
          puzzle[i][j] != puzzle[ii][jj];
        }
      }
      // Allow only numbers between 1 and 10
      puzzle[i][j] inside {[1:`SIZE]};
    }
  }

  // Generate a playable Sudoku puzzle by clearing cells
  function void generate_playable_puzzle();
    int mask[`SIZE][`SIZE];
    foreach (mask[i, j]) begin
      // Randomly clear cells to make it a playable puzzle
      mask[i][j] = $urandom_range(0, 1); // 50% chance to clear a cell
      if (mask[i][j] == 0) puzzle[i][j] = 0;
    end
  endfunction

  // Function to print the puzzle in a readable format
  function void print();
    $display("Generated 10x10 Sudoku Puzzle:");
    foreach (puzzle[i]) begin
      string row = "";
      foreach (puzzle[i][j]) begin
        row = {row, $sformatf("%2d ", puzzle[i][j])};
        // Add spacing for better visual separation of sub-grids
        if ((j + 1) % `M == 0 && j != `SIZE - 1) row = {row, "| "};
      end
      $display("%s", row);
      // Add horizontal divider after every 2 rows (sub-grid height)
      if ((i + 1) % `N == 0 && i != `SIZE - 1) 
        $display("-----------------------------------");
    end
  endfunction
endclass
