class Hangman
  attr_reader :guesser, :referee, :board
  
  def initialize(options = {})
    @guesser = options[:guesser]
    @referee = options[:referee]
  end
  
  def setup
    @board =  Array.new(@referee.pick_secret_word)
    @guesser.register_secret_length(@board.length)
  end
  
  def update_board(indexes, guess)
    indexes.each { |index| @board[index] = guess }
  end
  
  def display_board
    @board.each { |letter| letter.nil? ? print("_") : print(letter) }
    print("\n")
  end
  
  def over?
    @board.each { |spot| return false if spot.nil? }
    true
  end
  
  def take_turn
    guess = @guesser.guess(@board)
    places = @referee.check_guess(guess)
    self.update_board(places, guess)
    @guesser.handle_response(guess, places)
  end
  
  def play
    until over?
      display_board
      take_turn
    end
    puts "The word was #{ @board.join('') }!"
  end
  
end

class HumanPlayer
  attr_reader :guessed
  
  def initialize
    @guessed = []
  end
  
  def guess(board)
    good_guess = false
    until good_guess
      puts "Guess a letter:"
      guess = gets.chomp
      if @guessed.include?(guess)
        puts "You already guessed #{ guess }"
      else 
        good_guess = true
      end
    end
    guess
  end
  
  def pick_secret_word
    puts "Enter the length of your word"
    length = gets.chomp.to_i
  end
  
  def register_secret_length(len)
    @length = len
  end
  
  def check_guess(letter)
    puts "What indexes does this letter occur? (Type 'none' if letter is not in your word)"
    input = gets.chomp
    return [] if input == "none"
    indexes = input.split(" ").map { |index| index.to_i }
  end
  
  def handle_response(letter, indices)
    @guessed << letter
  end
  
end

class ComputerPlayer
  attr_reader :word, :length, :candidate_words
  
  def initialize(dictionary)
    if dictionary.is_a?(Array)
      @dictionary = dictionary
      @candidate_words = dictionary
    else
      file = File.open(dictionary, "r")
      contents = file.readlines
      stripped_contents = contents.map { |word| word.strip }
      @dictionary = stripped_contents
      @candidate_words = stripped_contents
    end
  end
  
  def guess(board)
    occurences = Hash.new(0)
    ("a".."z").to_a.each do |letter|
      @candidate_words.each do |word|
        occurences[letter] += word.count(letter)
      end
    end
    sorted = occurences.sort_by(&:last)
    #p sorted
    good_guess = false
    until good_guess
      current_guess = sorted.pop[0]
      good_guess = true if not board.include?(current_guess)
    end
    p "Computer guesses #{ current_guess }"
    current_guess
  end
  
  def pick_secret_word
    @word = @dictionary.sample
    @word.length
  end
  
  def register_secret_length(len)
    @length = len
    words = []
    @dictionary.each { |word| words << word if word.length == @length }
    @candidate_words = words
  end
  
  def check_guess(letter)
    indexes = (0...@word.length).find_all { |i| @word[i, 1] == letter }
  end
  
  def add_word?(word, letter, indices)
    add_word = true
    add_word = false if word.count(letter) != indices.count
    indices.each do |index|
      add_word = false if word[index] != letter
    end
    add_word
  end   
  
  def handle_response(letter, indices)
    words = []
    if indices.any?
      @candidate_words.each { |word| words << word if add_word?(word,letter, indices) }
    else
      @candidate_words.each { |word| words << word if not word.include? letter }
    end
    @candidate_words = words
  end
  
end

# player1 = HumanPlayer.new
# player2 = ComputerPlayer.new("dictionary.txt")
# game = Hangman.new({guesser: player1, referee: player2})
# game.setup
# game.play