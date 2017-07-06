class Board

  attr_accessor :board

  def initialize
    @board = Array.new(9) { Array.new(9) }
  end

  def rand_pos
    row = rand(9) - 1
    col = rand(9) - 1
    [row, col]
  end

  def add_bombs(count = 10)
    placed = count
    until placed == 0
      x, y = rand_pos
      if self.board[x][y] == nil
        self.board[x][y] = "*"
        placed -= 1
      end
    end
  end

  def add_fringe
    len = self.board.length - 1
    (0..len).each do |row|
      (0..len).each do |col|
        if self.board[row][col] == nil
          self.board[row][col] = count_bombs(row, col)
        end
      end
    end
  end

  def count_bombs(row, col)
    count = 0
    start_row = row - 1
    start_col = col - 1
    (start_row..start_row + 2).each do |i|
      if self.board[i] && i > -1
        (start_col..start_col + 2).each do |j|
          if self.board[j] && j > -1
            if self.board[i][j] == "*"
              count += 1
            end
          end
        end
      end
    end
    count
  end

  def rev_touches(row, col)
    start_row = row - 1
    start_col = col - 1
    (start_row..start_row + 2).each do |i|
      if self.board[i] && i > -1
        (start_col..start_col + 2).each do |j|
          if self.board[j] && j > -1
            if self.board[i][j] == 0
              self.board[i][j] = "T"
              rev_touches(i, j)
            end
          end
        end
      end
    end

  end

  def render
    len = self.board.length - 1
    (0..len).each do |row|
      (0..len).each do |col|
        print "#{self.board[row][col]} "
      end
      print "\n"
    end
  end

  def run
    self.add_bombs
    self.add_fringe
  end

end

if __FILE__ == $PROGRAM_NAME
  board1 = Board.new
  board1.run
  board1.board
  board1.render
end
