
class MazeSolver
  attr_accessor :grid, :start, :goal, :current, :copy

  def initialize
    @grid = []
    @visited = []
    @copy = []
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col] = value
  end

  def setup(file_name)
    @start = []
    @goal = []
    f = File.open(file_name)
    @grid = f.readlines
    @grid.map! { |line| line.split('') }

    grid.each_index do |x|
      grid[x].each_index do |y|
        @start << x << y if grid[x][y] == "S"
        @goal << x << y if grid[x][y] == "E"
      end
    end

    @current = @start
    @visited << @start

    @copy = @grid
  end

  def empty?(spot)
    self[spot] == " " ? true : false
  end

  def board_full?
    @grid.each do |row|
      row.each do |el|
        return false if el == " "
      end
    end
    true
  end

  def get_possible_moves
    possible = []
    adjacent = [[current[0] - 1, current[1]], [current[0] + 1, current[1]],
                [current[0], current[1] + 1], [current[0], current[1] - 1]]

    adjacent.each do |move|
      if self[move] == " " || self[move] == "E" && !@visited.include?(move)
        possible << move
      end
    end
    possible
  end

  def get_best_move(possible)
    possible.each do |move|
      if (@goal[0] - move[0]).abs < (@goal[0] - @current[0]).abs || (@goal[1] - move[1]).abs < (@goal[1] - @current[1]).abs
        return move
      end
    end
    possible.sample


  end

  def traverse
    until self[current] == "E"
      possible_moves = get_possible_moves
      next_move = get_best_move(possible_moves)
      # print @grid.join('')
      self[next_move] = "X" unless self[next_move] == "E"
      @visited << next_move
      @current = next_move
    end
    print @grid.join('')
    puts "You found the path!"
  end



end

if $PROGRAM_NAME == __FILE__
  maze_solver = MazeSolver.new
  maze_solver.setup(ARGV[0])
  maze_solver.traverse
end
