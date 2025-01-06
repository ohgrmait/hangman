require_relative 'game'
require_relative 'human'
require_relative 'computer'

class Hangman
  def initialize
    @game = Game.new
  end

  def start_game
    show_prompt
    play_game
  end

  def show_prompt
    puts '...A game of Hangman between two players: Human and Computer!'
    puts ''
    puts "...You can guess the opponent's secret word until two things:"
    puts '   (1) until the stick figure is completely hung or (2) total'
    puts '   of 8 incorrect guesses have been made by the player. It is'
    puts '   a word guessing game where the player will have the option'
    puts '   to both save the games at every turn and load a saved game'
    puts '   at the beginning of each turn when the program loads.'
  end

  def play_game
    print 'Do you want to load your saved game? '
    answer = gets.chomp
    if answer == 'y'
      @game.deserialize
      puts ''
      puts "secret word: #{@game.word}"
    else
      puts ''
      secret_word = @game.create_word
      puts "secret word: #{secret_word}"
    end

    puts ''

    @game.create_board
    loop do
      print 'your current word: '
      @game.current_display

      if @game.incorrect_letters.empty?
        puts 'incorrect letters: none'
      else
        puts "incorrect letters: #{@game.incorrect_letters.join(', ')}"
      end

      break if @game.incorrect_letters.length == 8 ||
               @game.board.all? { |w| w >= 'a' && w <= 'z' }

      puts ''

      print 'Do you want to save and exit at this point? '
      choice = gets.chomp
      if choice == 'y'
        @game.serialize
        break
      end

      print 'guess the letters: '
      @game.guess_letter

      puts ''

      @game.update_display

      @game.draw_hangman

      puts ''
    end
  end
end

hangman = Hangman.new
hangman.start_game
