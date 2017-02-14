def translate(word)
  vowels = ['a', 'e', 'i', 'o', 'u']
  marks = ['.', ',', '!', '?', ';', ':']
  word = word.split(" ")
  phrase = word.map do |this|
    cap = false
    cap = true if this.capitalize == this
    
    marks.include?(this[-1]) ? punct = true : punct = false
    i = 0
    i += 1 while not vowels.include?(this[i])
    i += 1 if this[i-1] == 'q' if this[i] == 'u'
    if punct
      i == 0 ? this[0...-1] << "ay" << this[-1] : this = this[i...-1] << this[0...i] << "ay" << this[-1]
    else
      i == 0 ? this << "ay" : this = this[i..-1] << this[0...i] << "ay"
    end
    cap ? this.capitalize! : this
  end.join(' ')
end

  