class Book
  BAD_WORDS = ["a", "the", "of", "and", "an", "in"]
  attr_accessor :title

  def title=(title)
   @title = title.capitalize
    words = @title.split(" ")
    new_words = words.map do |word|
      BAD_WORDS.include?(word) ? word : word.capitalize
    end
    @title = new_words.join(" ")
  end
  
end
