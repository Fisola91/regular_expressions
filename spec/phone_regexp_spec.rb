require "phone_regexp"

RSpec.describe "#french_phone_number?" do
  FIXTURES = {
    "0665363636" => true,
    "07 65 36 36 36" => true,
    "01-36-65-36-65" => true,
    "+33 6 65 36 36 36" => true,
    "+33665363636" => true,
    "+33065363636" => false,
    "02 65 36 36" => false,
    "0065363636" => false
  }

  FIXTURES.each do |phone_number, result|
    it "should #{result ? "accept" : "reject"} #{phone_number}" do
      expect(french_phone_number?(phone_number)).to eq(result)
    end
  end
end
