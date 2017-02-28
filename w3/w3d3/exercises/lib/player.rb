class HumanPlayer
  
  def initialize(name)
    @name = name
  end
  
  def get_play
    move = []
    puts "Enter a move in x,y format"
    string_move = gets.chomp.split(",")
    string_move.each { |item| move << item.to_i }
    move
  end
  
end
