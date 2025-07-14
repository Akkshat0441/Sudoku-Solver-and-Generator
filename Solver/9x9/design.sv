`define N 3
`define M 9

class my_item;
  rand int box[`M][`M];
  int puzzle[`M][`M] = '{
    '{ 0, 0, 6, 0, 0, 0, 0, 0, 0 },
    '{ 0, 0, 0, 0, 0, 5, 3, 0, 8 },
    '{ 0, 1, 3, 9, 0, 0, 0, 5, 4 },
    '{ 2, 0, 5, 0, 9, 0, 1, 0, 6 },
    '{ 0, 6, 9, 0, 8, 0, 0, 2, 7 },	
    '{ 3, 0, 0, 2, 1, 6, 0, 8, 0 },
    '{ 0, 0, 0, 0, 0, 7, 0, 4, 0 },
    '{ 0, 0, 8, 3, 0, 2, 5, 0, 0 },
    '{ 5, 0, 4, 1, 0, 0, 0, 0, 0 }
  };

  constraint tc {
    foreach (box[i, j]) {
      foreach (box[ii, jj]) {
        // Cannot have repeated numbers in the same row
        if (ii == i && jj != j) {
          box[i][j] != box[ii][jj];
        }
        // Cannot have repeated numbers in the same column
        if (ii != i && jj == j) {
          box[i][j] != box[ii][jj];
        }
        // Cannot have repeated numbers in the same 3x3 sub-grid
        if ((3 * (ii / 3) + (jj / 3)) == (3 * (i / 3) + (j / 3)) &&
            (i != ii || j != jj)) {
          box[i][j] != box[ii][jj];
        }
      }
      // Ensure each box contains numbers from 1 to 9
      box[i][j] inside {[1:9]};
      // Respect puzzle's preset values
      if (puzzle[i][j] != 0) {
        box[i][j] == puzzle[i][j];
      }
    }
  }

  function void print();
    string s;
    $display("Printing Sudoku:");
    foreach (box[i]) begin
      s = "";
      foreach (box[i][j]) begin
        s = {s, " ", $sformatf("%0d", box[i][j])};
      end
      $display("%s", s);
    end
  endfunction: print

endclass: my_item
