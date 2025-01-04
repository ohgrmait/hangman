require_relative 'computer'

class Hangman
  def initialize
    @computer = Computer.new
  end

  def start_game
    play_game
  end

  def play_game
    "secret word is #{@computer.create_word}"
  end
end

hangman = Hangman.new
puts hangman.start_game
