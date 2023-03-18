class Hangman
  @@word = ''
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
    contents = File.open("words.csv") #mute ko na lnag rin ako? 
    get_words(contents)
    asking_text()

    flag = true
    while flag == true
      guess = gets.chomp
      if guess.length == 1 && guess.match?(/[[:alpha:]]/)
        check_guess(guess)
        flag = false
      else
        puts "Type one letter:"
      end
    end
  end

  def check_guess(guess)
    word_array = @@word.chars
    print word_array
    if word_array.include?(guess)
      #find the index of the guessed letter and print it dun sa -----. 
    else
      
    end
  end

  def asking_text
    puts multi = <<-TEXT 
Guess the random word, it has #{@@word.length} letters:\n
    TEXT

    for i in 1..@@word.length do
    print "-"
    end

    puts multi2 = <<-TEXT
\n\nGuess one(1) letter.
You can also type 'save' or 'exit' to leave the game.
    TEXT
  end

  def get_words(contents)
    all = []

    contents.each do |i|
      if i.length() >= 5 && i.length() <= 12
        all.append(i.chop)
      end
    end

    @@word = all.sample
  end

  def load_game
    puts "Load"
  end
end

play = Hangman.new
play.start