# frozen_string_literal: true

require 'yaml'

class Game # rubocop:disable Style/Documentation
  attr_reader :incorrect_letters, :board, :word

  def initialize
    @word = nil
    @guess = nil
    @board = nil
    @player = Human.new
    @host = Computer.new
    @incorrect_letters = []
  end

  def create_word
    @word = @host.create_word
    @word
  end

  def guess_letter
    @guess = @player.guess_letter
    @guess
  end

  def create_board
    if @board.nil?
      @board = Array.new(@word.length, '_')
    elsif @board.any? { |e| e >= 'a' && e <= 'z' }
      @board
    end
  end

  def current_display
    @board.each do |elem|
      print "#{elem} "
    end
    puts ''
  end

  def update_display
    unless @word.include?(@guess)
      @incorrect_letters.push(@guess)
      return
    end

    @word.chars.each_with_index do |w, idx|
      @board[idx] = @guess if w == @guess
    end
  end

  def draw_hangman
    puts ''
    puts "\t\t   -------------" if @incorrect_letters.size > 0
    puts "\t\t  |      |      " if @incorrect_letters.size > 1
    puts "\t\t  |      O      " if @incorrect_letters.size > 2
    puts "\t\t  |     /|\\    " if @incorrect_letters.size > 3
    puts "\t\t  |      |      " if @incorrect_letters.size > 4
    puts "\t\t  |     / \\    " if @incorrect_letters.size > 5
    puts "\t\t  |    |   |    " if @incorrect_letters.size > 6
    puts "\t\t   -------------" if @incorrect_letters.size > 7
  end

  def serialize
    Dir.mkdir('saves') unless Dir.exist?('saves')
    File.open('saves/save.yaml', 'w') do |file|
      file.puts YAML.dump({
                            word: @word,
                            guess: @guess,
                            board: @board,
                            player: @player,
                            host: @host,
                            incorrect_letters: @incorrect_letters
                          }, aliases: true,
                             permitted_classes: [Computer, Human, Game, Symbol])
    end
  end

  def instance_variables(loaded_game)
    @word = loaded_game[:word]
    @guess = loaded_game[:guess]
    @board = loaded_game[:board]
    @player = loaded_game[:player]
    @host = loaded_game[:host]
    @incorrect_letters = loaded_game[:incorrect_letters]
  end

  def deserialize
    File.open('saves/save.yaml', 'r') do |file|
      loaded_game = YAML.safe_load(file, aliases: true, permitted_classes: [Computer, Human, Game, Symbol])
      instance_variables(loaded_game)
    end
  end

  def over?
    if @incorrect_letters.length == 8 ||
       @board.all? { |w| w >= 'a' && w <= 'z' }
      true
    end
  end
end
