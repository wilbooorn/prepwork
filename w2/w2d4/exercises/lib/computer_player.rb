class ComputerPlayer
  attr_reader :board
  attr_accessor :mark
  
  def initialize(name, mark = "")
    @name = name
    @mark = mark
  end
  
  def display(board)
    @board = board
  end
  
  def get_move
    result = []
    (0..2).each do |x|
      (0..2).each do |y|
        next if not @board[[x,y]].nil?
        @board[[x,y]] = @mark
        if not @board.winner.nil?
          result << x << y
          return result
        else
          @board[[x,y]] = nil
        end
      end
    end
    
    (0..2).each do |x|
      (0..2).each do |y|
        if @board[[x,y]].nil?
          result << x << y
          return result
        end
      end
    end
  end
  
end
