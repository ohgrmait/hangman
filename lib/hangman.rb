# frozen_string_literal: true

require 'colorize'

require_relative 'game'
require_relative 'human'
require_relative 'computer'

class Hangman # rubocop:disable Style/Documentation
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
      .colorize(color: :blue, mode: :bold)
    print ' '
    answer = gets.chomp
    raise StandardError unless %w[y n].include?(answer)
  rescue StandardError
    puts ''
    puts '--- Invalid input!!'
      .colorize(background: :red, mode: :bold, color: :light_yellow)
    puts ''
    retry
  else
    if answer == 'y'
      @game.deserialize
    else
      @game.create_word
    end
  end

  def save_game
    print '--- Save game(y/n)?'
      .colorize(color: :red, mode: :bold)
    print ' '
    choice = gets.chomp
    raise StandardError unless %w[y n].include?(choice)
  rescue StandardError
    puts ''
    puts '--- Invalid input!!'
      .colorize(background: :red, mode: :bold, color: :light_yellow)
    puts ''
    retry
  else
    return false unless choice == 'y'

    @game.serialize
    puts ''
    puts '--- Your game has been saved. Load to play it!'
      .colorize(color: :red, mode: :bold)
    true
  end

  def user_input
    print '--- Guess a letter: '
    guess = @game.guess_letter
    raise StandardError unless guess.length == 1 &&
                               (guess >= 'a' && guess <= 'z')
  rescue StandardError
    puts ''
    puts '--- Invalid input!!'
      .colorize(background: :red, mode: :bold, color: :light_yellow)
    puts ''
    retry
  else
    guess
  end

  def play_game
    @game.create_board

    loop do
      @game.draw_hangman if @game.incorrect_letters.size.positive?

      break if @game.over?

      puts ''

      print '--- Guess the word: '
      @game.current_display

      puts "--- incorrect word: #{@game.incorrect_letters.join(', ')}" unless @game.incorrect_letters.empty?

      puts ''

      break if save_game

      puts ''

      user_input

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
      puts "--- You used all incorrect guesses, word - #{@game.word}."
        .colorize(color: :red, mode: :bold)
    end
  end
end
