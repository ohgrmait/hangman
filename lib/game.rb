class Game
  def initialize
    @word = nil
    @guess = nil
    @board = nil
    @player = Human.new
    @host = Computer.new
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
end
