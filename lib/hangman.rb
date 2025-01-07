require 'colorize'

require_relative 'game'
require_relative 'human'
require_relative 'computer'

class Hangman
  def initialize
    @game = Game.new
  end

  def start_game
    show_prompt
    load_game
    play_game
    end_game
  end

  def show_prompt
    puts '--- A game of Hangman between two players: Human and Computer!'
    puts ''
    puts "--- You can guess the opponent's secret word until two things:"
    puts '    (1) until the stick figure is completely hung or (2) total'
    puts '    of 8 incorrect guesses have been made by the player. It is'
    puts '    a word guessing game where the player will have the option'
    puts '    to both save the games at every turn and load a saved game'
    puts '    at the beginning of each turn when the program loads.'
    puts ''
  end

  def load_game
    print '--- Load game(y/n)?'
      .colorize(background: :blue, color: :white, mode: :bold)
    print ' '
    answer = gets.chomp
    if answer == 'y'
      @game.deserialize
      puts ''
      puts "secret word: #{@game.word}"
    else
      puts ''
      secret_word = @game.create_word
      puts "--- secret word: #{secret_word}"
    end
  end

  def save_game
    print '--- Save game(y/n)?'
      .colorize(background: :red, color: :white, mode: :bold)
    print ' '
    choice = gets.chomp
    return false unless choice == 'y'

    @game.serialize
    puts ''
    puts '--- Your game has been saved. Load to play it!'
      .colorize(color: :red, mode: :bold)
    true
  end

  def play_game
    @game.create_board

    loop do
      @game.draw_hangman if @game.incorrect_letters.size.positive?

      break if @game.over?

      puts ''

      print '--- Guess the word: '
      @game.current_display

      puts "--- incorrect letters: #{@game.incorrect_letters.join(', ')}" unless @game.incorrect_letters.empty?

      puts ''

      break if save_game

      puts ''

      print '--- Guess a letter: '
      @game.guess_letter

      @game.update_display
    end
  end

  def end_game
    if @game.board.all? { |w| w >= 'a' && w <= 'z' }
      puts ''
      puts "--- Game over! You found the secret word - #{@game.word}."
        .colorize(color: :green, mode: :bold)
    elsif @game.incorrect_letters.length == 8
      puts ''
      puts '--- Play again! You used up incorrect guesses.'
        .colorize(color: :red, mode: :bold)
    end
  end
end

hangman = Hangman.new
hangman.start_game
