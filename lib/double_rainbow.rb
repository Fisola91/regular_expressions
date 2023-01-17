class DoubleRainbow

  def initialize(sentence)
    @sentence = sentence
  end

  def word_contains_at_least_two_p
    sentence.match(/\bp\w+/)[0]
  end

  def word_before_exclamation_mark
    sentence.match(/(\w+)!/)[1]
  end

  def four_letter_word
    sentence.match(/(b\w{3}),/)[1]
  end

  def last_five_letters
    sentence.match(/\w+$/)[0]
  end

  def word_contains_ll
    sentence.match(/\w+ll\w+/)[0]
  end

  def six_letter_word
    sentence.match(/[a-r]{6}/)[0]
  end

  def all_capital_letters
    sentence.scan(/[A-Z]/).join
  end

  private
  attr_reader :sentence
end
