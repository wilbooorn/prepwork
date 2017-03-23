# Towers of Hanoi
#
# Write a Towers of Hanoi game:
# http://en.wikipedia.org/wiki/Towers_of_hanoi
#
# In a class `TowersOfHanoi`, keep a `towers` instance variable that is an array
# of three arrays. Each subarray should represent a tower. Each tower should
# store integers representing the size of its discs. Expose this instance
# variable with an `attr_reader`.
#
# You'll want a `#play` method. In a loop, prompt the user using puts. Ask what
# pile to select a disc from. The pile should be the index of a tower in your
# `@towers` array. Use gets
# (http://andreacfm.com/2011/06/11/learning-ruby-gets-and-chomp.html) to get an
# answer. Similarly, find out which pile the user wants to move the disc to.
# Next, you'll want to do different things depending on whether or not the move
# is valid. Finally, if they have succeeded in moving all of the discs to
# another pile, they win! The loop should end.
#
# You'll want a `TowersOfHanoi#render` method. Don't spend too much time on
# this, just get it playable.
#
# Think about what other helper methods you might want. Here's a list of all the
# instance methods I had in my TowersOfHanoi class:
# * initialize
# * play
# * render
# * won?
# * valid_move?(from_tower, to_tower)
# * move(from_tower, to_tower)
#
# Make sure that the game works in the console. There are also some specs to
# keep you on the right track:
#
# ```bash
# bundle exec rspec spec/towers_of_hanoi_spec.rb
# ```
#
# Make sure to run bundle install first! The specs assume you've implemented the
# methods named above.

class TowersOfHanoi
  attr_reader :towers

  def initialize
    @towers = [[3, 2, 1], [], []]
    @moves = 0
  end

  def play
    until won?
      self.render
      print "\n"
      puts "Total moves: #{@moves}"
      puts "Select a tower to move from: "
      from = gets.chomp.to_i
      puts "Select a tower to move to: "
      to = gets.chomp.to_i
      unless valid_move?(from, to)
        puts "That's not a valid move"
        next
      end
      move(from, to)
      @moves += 1
    end

  end

  def render
    @towers.each_index do |tower_index|
      p @towers[tower_index]
    end
  end

  def won?
    return false unless towers[1].size == 3 or towers[2].size == 3
    p "You win!!"
    true
  end

  def valid_move?(from_block, to_block)
    return false if not @towers[from_block].any?
    return true if not @towers[to_block].any?
    return true if @towers[from_block][-1] < @towers[to_block][-1]
    false
  end

  def move(from_block, to_block)
    @towers[to_block].push(@towers[from_block].pop)
  end


end

# game = TowersOfHanoi.new
# game.play
