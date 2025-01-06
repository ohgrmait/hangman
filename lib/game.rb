class Game
  def initialize
    @word = nil
    @board = nil
    @host = Computer.new
  end

  def create_word
    @word = @host.create_word
    @word
  end

  def create_board
    @board = Array.new(@word.length, '_')
  end
end
