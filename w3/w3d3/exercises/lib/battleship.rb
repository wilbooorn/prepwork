require_relative "board"
require_relative 'player'

class BattleshipGame
  attr_reader :board, :player
  
  def initialize(player, board)
    @player = player
    @board = board
  end
  
  def attack(spot)
    @board[spot] = :x 
  end
  
  def count
    @board.count
  end
  
  def game_over?
    @board.won?
  end
  
  def play_turn
    move = @player.get_play
    attack(move)
  end
  
  def play_game
    until game_over?
      play_turn
    end
    puts "Yay you win!"
  end
  
end

player = HumanPlayer.new("Robin")
board = Board.new([[:s, :s], [nil, nil]])
game = BattleshipGame.new(player, board)
game.play_game
