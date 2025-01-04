class Hangman
  def start_game
    play_game
  end

  def play_game
    puts 'Hangman Initialized!'
  end
end

hangman = Hangman.new
hangman.start_game
