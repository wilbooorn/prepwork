require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'

class Game
  attr_accessor :board
  attr_accessor :current_player

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @board = Board.new
    @current_player = player1
  end

  def switch_players!
    @current_player == @player1 ? @current_player = @player2 : @current_player = @player1
  end

  def play_turn
    @current_player.display(@board)
    move = @current_player.get_move
    @board.place_mark(move, @current_player.mark)
    switch_players!
  end


  def play_game
    until @board.over?
      play_turn
    end
    switch_players!
    @board.grid.each { |row| p row }
    puts "#{@current_player.name} wins!"
  end
end
# 
# p1 = HumanPlayer.new("Robin", :X)
# p2 = ComputerPlayer.new("Brian", :O)
#
# game = Game.new(p1, p2)
# game.play_game
