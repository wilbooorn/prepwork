def reverser(&prc)
  words = prc.call
  word_arr = words.split(' ')
  word_arr.each do |word|
    word.reverse!
  end .join(' ')
end

def adder(plus = 1, &prc)
  num = prc.call
  num + plus
end

def repeater(quantity = 1, &prc)
  quantity.times { prc.call }
end
