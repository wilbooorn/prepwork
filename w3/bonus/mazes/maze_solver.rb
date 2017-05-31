
class MazeSolver
  attr_accessor :grid, :start, :goal, :current

  def initialize
    @grid = []
    @visited = []
    @previous = []
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

  def repeat_last_move(previous, current)
    #Based on previous space and cuerrent space, returns a move that will
    #repeat that same movement

    xdif = previous[1] - current[1]
    ydif = previous[0] - current[0]
    if xdif == -1
      return [current[0], current[1] + 1]
    elsif xdif == 1
      return [current[0], current[1] - 1]
    elsif ydif == -1
      return [current[0] + 1, current[1]]
    elsif ydif == 1
      return [current[0] - 1, current[1]]
    end
  end

  def get_possible_moves
    #Returns a list of all adjacent squares, excluding ones that are not
    #walkable (Walls, already visited, etc.).

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
    #Chooses the best move of possible moves, or repeats the previous move,
    #based on the possible moves to take

    possible.each do |move|
      if (@goal[0] - move[0]).abs < (@goal[0] - @current[0]).abs ||
        (@goal[1] - move[1]).abs < (@goal[1] - @current[1]).abs
        @previous = move
        return move
      end
    end
    possible.size == 1 ? possible[0] : repeat_last_move(@previous, @current)
  end

  def solve
    #Repeatedly fetches new move until the end is reached

    until self[current] == "E"
      s = Time.now
      possible_moves = get_possible_moves
      next_move = get_best_move(possible_moves)
      #****Uncomment to view each step****
      print @grid.join('')
      self[next_move] = "X" unless self[next_move] == "E"
      @visited << next_move
      @previous = @current
      @current = next_move
    end
    f = Time.now
    time = (f - s) * 1000
    print @grid.join('')
    puts "You found the path in #{time}ms!"
  end



end

if $PROGRAM_NAME == __FILE__
  maze_solver = MazeSolver.new
  maze_solver.setup(ARGV[0])
  maze_solver.solve
end
