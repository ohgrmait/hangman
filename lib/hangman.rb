require_relative 'game'
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
    @game.create_board
  end
end

hangman = Hangman.new
hangman.start_game
