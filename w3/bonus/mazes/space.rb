class Space
  attr_accessor :value, :parent

  def initialize(value = "")
    @value = value
    @parent = nil
    @distance = 0
  end

end
