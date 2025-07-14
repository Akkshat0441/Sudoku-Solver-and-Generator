`define N 4
`define M 16

class my_item;
  rand int box[`M][`M];
  int puzzle[`M][`M] = '{
    '{ 7, 13, 0, 0, 5, 0, 14, 0, 0, 0, 16, 10, 0, 0, 0, 8 },
    '{ 0, 0, 0, 15, 8, 13, 6, 7, 4, 0, 0, 0, 16, 0, 0, 0 },
    '{ 12, 0, 0, 9, 10, 15, 0, 0, 7, 0, 0, 14, 13, 0, 4, 6 },
    '{ 0, 0, 14, 0, 0, 3, 0, 0, 0, 0, 0, 5, 7, 0, 15, 0 },
    '{ 0, 0, 0, 7, 0, 0, 4, 5, 6, 0, 0, 9, 0, 0, 16, 13 },
    '{ 0, 11, 2, 0, 0, 0, 1, 10, 15, 3, 13, 0, 6, 4, 7, 9 },       
    '{ 16, 0, 6, 0, 14, 0, 0, 0, 0, 4, 7, 8, 11, 15, 0, 5 },
    '{ 0, 0, 0, 12, 3, 9, 0, 0, 5, 16, 0, 11, 0, 0, 8, 0 },
    '{ 0, 4, 3, 0, 0, 0, 15, 0, 0, 12, 8, 0, 0, 9, 0, 16 },
    '{ 14, 0, 0, 0, 0, 0, 0, 3, 0, 13, 0, 1, 0, 8, 0, 0 },
    '{ 0, 1, 15, 2, 0, 0, 12, 14, 16, 11, 0, 0, 5, 0, 6, 0 },
    '{ 0, 7, 0, 16, 13, 2, 9, 8, 0, 5, 15, 0, 14, 0, 0, 4 },
    '{ 0, 12, 0, 0, 0, 6, 5, 0, 0, 0, 10, 0, 9, 16, 14, 3 },
    '{ 0, 0, 8, 1, 0, 0, 0, 11, 0, 14, 0, 0, 0, 0, 0, 0 },
    '{ 0, 0, 0, 0, 0, 0, 0, 12, 0, 1, 0, 0, 8, 7, 13,0 },
    '{ 10, 0, 13, 3, 0, 0, 8, 15, 0, 0, 0, 0, 2, 12, 0, 0 }
 
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
          if ((4 * (ii / 4) + (jj / 4)) == (4 * (i / 4) + (j / 4)) &&
            (i != ii || j != jj)) {
          box[i][j] != box[ii][jj];
        }
      }
      // Ensure each box contains numbers from 1 to 9
            box[i][j] inside {[1:16]};
      // Respect puzzle's preset values
      if (puzzle[i][j] != 0) {
        box[i][j] == puzzle[i][j];
      }
    }
  }

  function string get_sym(int n);
    string s;
    if (n == 1) s = "X";
    else if (n == -1) s = "O";
    else if (n == 0) s = " ";
    return s;
  endfunction: get_sym

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
