class Hangman
  @@word = ''
  @@attempt = 10
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
    contents = File.open("words.csv") 
    get_words(contents)
    asking_text()

    letter_guessed = []
    print @@word
    blank_words = Array.new(@@word.length, "-")

    while @@attempt > 0
      puts multi2 = <<-TEXT
\n\nGuess one(1) letter. You have #{@@attempt} attempt/s left
You can also type 'save' or 'exit' to leave the game.
Guessed letters #{letter_guessed}
TEXT

      guess = gets.chomp
      if letter_guessed.include?(guess)
          print "\n\e[31mLetter already guessed. Type another letter\e[0m"
      else
        if guess.length == 1 && guess.match?(/[[:alpha:]]/)
          check_guess(guess, blank_words)
        else
          puts "Type one letter:"
        end
        letter_guessed.append(guess)
      end
    end
    out_of_lives()
  end

  def repeat(arr)
    flag = true
    while flag == true
      guess = gets.chomp
      if arr.include?(guess)
        print "Type another letter: "
      else
        flag = false
      end
    end
  end

  def check_guess(guess, blank_words)
    word_array = @@word.chars
    val = word_array.detect { |i| word_array.count(i) > 1}

    if guess == val
      word_array.each_with_index do |letter, idx|
        if letter == val
          blank_words[idx] = letter
        end
      end
    end

    if word_array.include?(guess)
      #find the index of the guessed letter and print it dun sa -----. 
      #what if there are 2 or more letters to print
      guessed_letter_index = @@word.index(guess)
      blank_words[guessed_letter_index] = guess

      print_this(blank_words)
    else
      if @@attempt == 0
        out_of_lives()
      end
      print_this(blank_words)
      @@attempt -= 1
    end
  end

  def out_of_lives
    puts "\nYou lost! There are no more guesses left."
    exit
  end

  def print_this(arr)
    puts ""
    arr.each { |i| print i}
  end

  def asking_text
    puts multi = <<-TEXT 
Guess the random word, it has #{@@word.length} letters:\n
    TEXT

    for i in 1..@@word.length do
      print "-"
      end
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