class Board
  attr_reader :grid
  
  def initialize(grid = Board.default_grid)
    @grid = grid
  end
   
   def self.default_grid
     @grid = Array.new(10) { Array.new(10) }
   end
     
    def count
      total = 0
      @grid.each do |row|
        row.each { |item| total += 1 if not item.nil? }
      end
      total
    end
    
    def [](pos)
      row, col = pos
      @grid[row][col]
    end
    
    def []=(pos, val)
      row, col = pos
      @grid[row][col] = val
    end
    
    def empty?(pos = nil)
      if pos
        row, col = pos
        @grid[row][col].nil? ? true : false
      else
        @grid.each do |row|
          row.each { |place| return false if not place.nil? || place == :x }
        end
        true
      end
    end
    
    def full?
      @grid.each do |row|
          row.each { |place| return false if place.nil? }
      end
      true
    end
    
    def place_random_ship
      raise "Board is full" if self.full?
      to_place = [rand(0...@grid.length), rand(0...@grid[0].length)]
      until self.empty?(to_place)
        to_place = [rand(0...@grid.length), rand(0...@grid[0].length)]
      end
      self[to_place] = :s
    end
    
    def won?
      self.empty? ? true: false
    end
    
end
