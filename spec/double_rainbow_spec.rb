require "double_rainbow"

RSpec.describe DoubleRainbow do
  SENTENCE = "Reveal the logos' colors:\
  Elegant shapes, some have evolved to a very iconized style.\
  Definitely a vivid color scheme with bright orange and shiny yellow,\
  many shades of blue, oscillating between purple and indigo! but not much green"

  let(:secret_message) { DoubleRainbow.new(SENTENCE) }
  it "returns the first word containing two 'p's or more" do
    expect(secret_message.word_contains_at_least_two_p).to eq("purple")
  end

  # it "returns first word located befpre an exclamation mark" do
  #   expect(secretword_before_exclamation_mark).to eq("indigo")
  # end
end