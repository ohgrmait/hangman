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
    secret_word = @game.create_word
    puts "secret word: #{secret_word}"

    puts ''

    @game.create_board
    loop do
      print 'your current word: '
      @game.current_display

      puts ''

      print 'guess the letters: '
      @game.guess_letter

      puts ''
    end
  end
end

hangman = Hangman.new
hangman.start_game
