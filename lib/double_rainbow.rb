class DoubleRainbow
  def initialize(sentence)
    @sentence = sentence
  end

  def word_contains_at_least_two_p
    sentence.match(/\bp\w+/)[0]
  end

  def word_before_exclamation_mark
    sentence.match(/(\w+)(!)/)[1]
  end



  private
  attr_reader :sentence
end
