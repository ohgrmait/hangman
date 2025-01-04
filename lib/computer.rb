class Computer
  def initialize
    @dict = File.readlines('google-10000-english-no-swears.txt')
    @words = @dict.reject do |word|
      word.length < 5 || word.length > 12
    end
  end

  def create_word
    @words.sample.strip
  end
end
