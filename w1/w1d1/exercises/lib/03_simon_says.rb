def echo(word)
  word
end

def shout(word)
  word.upcase
end

def repeat(word, times = 2)
  ([word] * times).join ' '
end

def start_of_word(word, letters = 1)
  word[0,letters]
end

def first_word(word)
  word.split(' ')[0]
end

def titleize(word)
  bad_words = ["and", "or", "the", "over", "to", "the", "a", "but"]
  word.capitalize!
  title = word.split(' ').map { |word| bad_words.include?(word) ? word : word.capitalize }.join ' '
end