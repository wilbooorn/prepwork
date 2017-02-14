def add( x, y)
  x + y
end

def subtract(x, y)
  x - y
end

def sum(nums)
  x = 0
  nums.each do |num|
    x += num
  end
  x
end

def multiply(x, *y)
  y.each { |num| x *= num }
  x
end

def power(num, exp)
  num**exp
end

def factorial(num)
  return 0 if num == 0
  return 1 if num == 1
  return num * factorial(num - 1)
end