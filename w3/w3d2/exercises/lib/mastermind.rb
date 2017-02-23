class Code
  attr_reader :pegs
  PEGS = {}
  VALID = ["r", "b", "g", "o", "y", "p"]
  
  def initialize(pegs)
    @pegs = pegs
  end
  
  def self.parse(string)
    colors = string.downcase.split('')
    colors.each { |color| raise "Invalid colors" if not VALID.include?(color) }
    Code.new(colors)
  end
  
  def self.random
    random_list = []
    4.times { random_list << VALID.sample }
    Code.new(random_list)
  end
  
  def [](position)
    @pegs[position]
  end
  
  def exact_matches(other_code)
    total = 0
    (0...@pegs.length).each { |index| total += 1 if @pegs[index] == other_code.pegs[index] }
    total
  end
  
  def near_matches(other_code)
    total = 0
    dont_include = []
    other_index = 0
    (0...@pegs.length).each do |index|
      if @pegs[index] != other_code.pegs[index]
        if other_code.pegs.include?(@pegs[index]) && (not dont_include.include?(@pegs[index]))
          other_index = other_code.pegs.index(@pegs[index])
          if @pegs[other_index] != other_code.pegs[other_index]
            total += 1
            dont_include << @pegs[index]
          end
        end
      end
    end
    total
  end
  
  def ==(other_code)
    return false if not other_code.is_a?(Code)
    return true if @pegs == other_code.pegs
    false
  end
  
end

class Game
  attr_reader :secret_code
  
  def initialize(secret_code = Code.random)
    @secret_code = secret_code
  end
  
  def get_guess
    puts "Enter your guess."
    string = gets.chomp
    Code.new(string.split(''))
  end
  
  def display_matches(code)
    exact = @secret_code.exact_matches(code)
    near = @secret_code.near_matches(code)
    puts "exact: #{ exact }"
    puts "near: #{ near }"
  end
  
end
