require_relative "space"

class MazeSolver
  attr_accessor :start, :grid

  def initialize
    @grid = []
    @visited = []
    @path = []
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

  end


  def find_path(row, col)

    if @grid[row][col] == "E"
      @path << [row, col]
      return true
    end

    unless @visited.include?([row, col]) || @grid[row][col] == "*"
      @visited << [row, col]

      if find_path(row + 1, col)
        @path << [row, col]
        return true
      end

      if find_path(row - 1, col)
        @path << [row, col]
        return true
      end

      if find_path(row, col + 1)
        @path << [row, col]
        return true
      end

      if find_path(row, col - 1)
        @path << [row, col]
        return true
      end

    end
    false
  end

  def fill_maze
    @path.each { |place| self[place] = "X" unless "ES".include? self[place] }
    puts "No path found..." unless @path.any?
    print @grid.join('')
  end


end

if $PROGRAM_NAME == __FILE__
  maze_solver = MazeSolver.new
  maze_solver.setup(ARGV[0])
  maze_solver.find_path(maze_solver.start[0], maze_solver.start[1])
  maze_solver.fill_maze
end
