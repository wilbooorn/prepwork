
class Fixnum
  BIG_WORDS = { 100 => "hundred", 1000 => "thousand", 1000000 => "million", 1000000000 => "billion", 1000000000000 => "trillion" }

  
  def find_magnitude
    BIG_WORDS.keys.take_while { |magnitude| magnitude <= self }.last
  end
  
  def in_words(num = self)
    small_words = {0 => "zero", 1 => "one", 2 => "two", 3 => "three", 4 => "four", 5 => "five", 6 => "six", 7 => "seven", 8 => "eight", 9 => "nine",
                    10 => "ten", 11 => "eleven", 12 => "twelve", 13 => "thirteen", 14 => "fourteen", 15 => "fifteen", 16 => "sixteen",
                    17 => "seventeen", 18 => "eighteen", 19 => "nineteen",
                    20 => "twenty", 30 => "thirty", 40 => "forty", 50 => "fifty", 60 => "sixty", 70 => "seventy", 80 => "eighty", 90 => "ninety"}
                    
    if small_words.has_key?(self) 
      small_words[self]
    elsif self <= 99
       [small_words[self - self % 10], small_words[self % 10]].join(" ")
    else
      magnitude = find_magnitude
      magnitude_words =
        (self / magnitude).in_words + " " + BIG_WORDS[magnitude]
      if (self % magnitude) != 0
        magnitude_words + " " + (self % magnitude).in_words
      else
        magnitude_words
      end
    end
  end
end