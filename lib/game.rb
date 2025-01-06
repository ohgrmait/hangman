class Game
  attr_reader :incorrect_letters

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
    @board = Array.new(@word.length, '_')
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
end
