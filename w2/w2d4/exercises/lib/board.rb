class Board
  attr_accessor :grid
  
  def initialize(grid = Array.new(3) { Array.new(3) })
    @grid = grid
  end
  
  def [](position)
    row, col = position
    @grid[row][col]
  end
  
  def []=(position, mark)
    row, col = position
    @grid[row][col] = mark
  end
  
  def place_mark(position, mark)
    self[position] = mark
  end
  
  def empty?(position)
    self[position] == nil ? true : false
  end
  
  def check_rows
    (0..2).each do |row|
      return @grid[row][0] if @grid[row][0] == @grid[row][1] && @grid[row][0] == @grid[row][2] && @grid[row][0] != nil
    end
    nil
  end
  
  def check_columns
    (0..2).each do |col|
      return @grid[0][col] if @grid[0][col] == @grid[1][col] && @grid[0][col] == @grid[2][col] && @grid[0][col] != nil
    end
    nil
  end
  
  def check_diags
    return @grid[0][0] if @grid[0][0] == @grid[1][1] && @grid[0][0] == @grid[2][2] && @grid[0][0] != nil
    return @grid[0][2] if @grid[0][2] == @grid[1][1] && @grid[0][2] == @grid[2][0] && @grid[0][2] != nil
    nil
  end
  
  def winner
    return check_columns unless check_columns.nil?
    return check_rows unless check_rows.nil?
    return check_diags unless check_diags.nil?
    nil
  end
  
  def full?
    (0..2).each do |x|
      (0..2).each do |y|
        return false if @grid[x][y].nil?
      end
    end
    true
  end
  
  def over?
    return true unless winner.nil? and not self.full?
  end
  
end
