class Hangman
  def start
    introduction()
    flag = true
    while flag == true
    selected = gets.chomp
      if selected == "1"
        new_game()
        flag = false
      elsif selected == "2"
        load_game()
        flag = false
      else
        puts "\nError: Type 1 or 2 only"
      end
    end
  end

  def introduction
    multi = <<-TEXT
A random word with 5-12 letters will be choses. On each turn, 
you can guess one letter. To win, you must find all the letters in the word 
before using 10 incorrect guesses.

[1] Play a new game
[2] Load a saved game
TEXT
    puts multi
  end

  def new_game
    puts "New"
  end

  def load_game
    puts "Load"
  end
end

play = Hangman.new
play.start