require "marketing_campaign"

RSpec.describe "marketing campaign" do
  EMAIL = {
    "dimitri@lewagon" => false,
    "@lewagon" => false,
    "boris@lewagoncom" => false,
    "seb@lewagon.com" => true,
    "fisola@lewagon.com" => true,
    "charles@lewagon.com" => true
  }
  context "when email is valid or invalid" do
    EMAIL.each do |email, result|
      outcome = result ? "valid" : "invalid"
      it "returns #{result ? true : false } for #{outcome} email" do
        expect(valid?(email)).to eq(result)
      end
    end

  end
end
