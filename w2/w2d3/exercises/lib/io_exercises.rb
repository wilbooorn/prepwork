# I/O Exercises
#
# * Write a `guessing_game` method. The computer should choose a number between
#   1 and 100. Prompt the user to `guess a number`. Each time through a play loop,
#   get a guess from the user. Print the number guessed and whether it was `too
#   high` or `too low`. Track the number of guesses the player takes. When the
#   player guesses the number, print out what the number was and how many guesses
#   the player needed.
# * Write a program that prompts the user for a file name, reads that file,
#   shuffles the lines, and saves it to the file "{input_name}-shuffled.txt". You
#   could create a random number using the Random class, or you could use the
#   `shuffle` method in array.

def guessing_game
    
    guessed = false
    guesses = 0
    the_number = Random.rand(1..100)
    
    until guessed
        guesses += 1
        puts "Guess a number"
        current_guess = gets.chomp.to_i
        puts "You guessed #{current_guess}"
        puts "Guesses: #{guesses}"
        guessed = true if current_guess == the_number
        puts "too high" if current_guess > the_number
        puts "too low" if current_guess < the_number
        
    end
    puts "The number was #{the_number}."
    puts "It took #{guesses} tries!"
end

def shuffler
    
    file_name = ""
    puts "Enter a file"
    file_name = gets.chomp
    stripped = file_name.split(".")
    shuffled_file = "#{stripped[0]}-shuffled.txt"
    
    file = File.open(file_name, "r")
    contents = file.readlines
    shuffled = contents.shuffle
    
    new_file = File.open(shuffled_file, "w")
    shuffled.each { |line| new_file.puts line }
    
    new_file.close
    file.close
end

