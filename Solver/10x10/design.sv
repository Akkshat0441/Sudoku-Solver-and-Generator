`define N 5
`define M 10

class my_item;
  rand int box[`M][`M];
  int puzzle[`M][`M] = '{
    '{ 4, 0, 0, 0, 0, 0, 0, 7, 5, 1 },
    '{ 9, 0, 6, 0, 0, 0, 0, 10, 4, 8 },
    '{ 2, 5, 0, 0, 8, 0, 10, 6, 0, 9 },
    '{ 7, 0, 1, 6, 0, 5, 0, 0, 2, 0 },
    '{ 0, 10, 0, 3, 6, 2, 0, 0, 8, 0 },
    '{ 5, 0, 9, 2, 0, 0, 0, 0, 3, 0 },
    '{ 0, 0, 7, 0, 4, 0, 1, 2, 0, 3 },
    '{ 0, 0, 0, 8, 9, 0, 4, 0, 10, 6 },
    '{ 0, 3, 5, 0, 1, 0, 7, 0, 0, 0 },
    '{ 0, 4, 10, 7, 0, 9, 0, 8, 0, 0 }
        
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
          if ((5 * (ii / 2) + (jj / 5)) == (5 * (i / 2) + (j / 5)) &&
            (i != ii || j != jj)) {
          box[i][j] != box[ii][jj];
        }
      }
      // Ensure each box contains numbers from 1 to 10
            box[i][j] inside {[1:10]};
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
