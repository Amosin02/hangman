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
    blank_words = Array.new(@@word.length, "-")
    print @@word

    while @@attempt > 0
      puts multi2 = <<-TEXT
\n\nGuess one(1) letter. You have #{@@attempt} attempt/s left
You can also type 'save' or 'exit' to leave the game.
Guessed letters #{letter_guessed.join(" ")}
TEXT

      guess = gets.chomp

      if guess == 'save'
        file_create()
      end

      if letter_guessed.include?(guess)
          print "\n\e[31mLetter already guessed. Type another letter\e[0m"
      else
        if guess.length == 1 && guess.match?(/[[:alpha:]]/)
          check_guess(guess, blank_words)
          check_answer(blank_words)

          letter_guessed.append(guess)
        else
          puts "Type one letter:"
        end
      end
    end
    out_of_lives()
  end

  def file_create() ## create a file, the file should save the game
    puts "Enter filename"
    filename = gets.chomp

    Dir.mkdir('files') unless Dir.exist?('files')

    File.open(filename, 'w')
    exit
  end

  def check_answer(arr)
    if arr.join("") == @@word
      congratulations()
    end
  end

  def check_guess(guess, blank_words)
    word_array = @@word.chars

    val = word_array.select { |e| word_array.count(e) > 1 }.uniq

    if val.include?(guess) 
      one_letter = val.select { |a| a == guess}
      word_array.each_with_index do |letter, idx|
        if letter == one_letter.join("")
          blank_words[idx] = letter
        end
      end
    end

    if word_array.include?(guess)
      guessed_letter_index = @@word.index(guess)
      blank_words[guessed_letter_index] = guess

      print_this(blank_words)
    else
      print_this(blank_words)
      @@attempt -= 1
    end
  end

  def play_again
    puts n = <<-TEXT
Would you like to play again?

[1] yes 
[any key] no

    TEXT

    ans = gets.chomp
    if ans == "1"
      start()
    else
      exit
    end
  end

  def out_of_lives
    puts "\n\nYou lost! There are no more guesses left. The word was: #{@@word}"
    play_again()
  end

  def print_this(arr)
    puts ""
    arr.each { |i| print i}
  end

  def congratulations() #winning word
    puts "\n\nYou guessed the word!"
    play_again()
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
      n = i.chop
      if n.length() >= 5 && n.length() <= 12
        all.append(n)
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