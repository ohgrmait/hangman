class Game
  def initialize
    @host = Computer.new
  end

  def create_word
    @host.create_word
  end
end
