class RPNCalculator
  attr_accessor :calculator
  
  def initialize()
      @calculator = []
  end
  
  def push(num)
      @calculator << num
  end
  
  def value
      @calculator[-1]
  end
  
  def plus
      raise "calculator is empty" if @calculator.size < 2
      @calculator[-1] = @calculator[-2] + @calculator[-1]
      @calculator.delete(@calculator[-2])
  end
  
  def minus
      raise "calculator is empty" if @calculator.size < 2
      @calculator[-1] = @calculator[-2] - @calculator[-1]
      @calculator.delete(@calculator[-2])
  end
  
  def times
      raise "calculator is empty" if @calculator.size < 2
      @calculator[-1] = @calculator[-2] * @calculator[-1]
      @calculator.delete(@calculator[-2])
  end
  
  def divide
      raise "calculator is empty" if @calculator.size < 2
      @calculator[-1] = @calculator[-2].to_f / @calculator[-1].to_f
      @calculator.delete(@calculator[-2])
  end
  
  def tokens(string)
      string_list = string.split(" ")
      result = string_list.map do |item|
        item.to_i > 0 ? item.to_i : item.to_sym
      end
      result
  end
  
  def evaluate(string)
    tokens = tokens(string)
    tokens.each do |item|
      if item.is_a?(Integer)
        push(item)
      elsif item == :*
        times
      elsif item == :+
        plus
      elsif item == :/
        divide
      elsif item == :-
        minus
      end
    end
    value
  end
  
end
