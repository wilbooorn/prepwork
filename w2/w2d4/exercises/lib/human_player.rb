class HumanPlayer
  attr_reader :name
  attr_accessor :mark
  
  def initialize(name, mark = "")
    @name = name
    @mark = mark
  end
  
  def get_move
    puts "Where"
    move = gets.chomp.split(",").map { |num| num.to_i }
  end
  
  def display(board)
    board.grid.each { |row| p row }
  end
  
end
