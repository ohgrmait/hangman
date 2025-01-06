require_relative 'game'
require_relative 'human'
require_relative 'computer'

class Hangman
  def initialize
    @game = Game.new
  end

  def start_game
    play_game
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
