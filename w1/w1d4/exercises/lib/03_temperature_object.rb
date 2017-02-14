class Temperature
  attr_accessor :temp

  def initialize(option)
    @option = option
    @fahrenheit = @option[:f]
    @celsius = @option[:c]
  end
  
  def ctof(temp)
    (temp * (9.0/5.0)) + 32
  end
  
  def ftoc(temp)
    (temp - 32) * (5.0/9.0)
  end
    
  def in_fahrenheit
    if @fahrenheit 
      @fahrenheit
    else
      ctof(@celsius)
    end
  end
  
  def in_celsius
    if @celsius
      @celsius
    else
      ftoc(@fahrenheit)
    end
  end
  
  def self.from_celsius(num)
    Temperature.new({ :c => num })
  end
  
  def self.from_fahrenheit(num)
    Temperature.new({ :f => num })
  end
  
end

class Celsius < Temperature
  def initialize(temp)
    @celsius = temp
  end
end
  
class Fahrenheit < Temperature
  def initialize(temp)
    @fahrenheit = temp
  end
end