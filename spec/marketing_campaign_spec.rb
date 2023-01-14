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

    context "when array of valid emails" do
      it "returns an array with valid emails only" do
        let(:valid_email_array) {[]}
        EMAIL.each do |email, result|
          valid_email_array << email if EMAIL[email] == true
        end
        expect(clean_database(EMAIL.keys)).to match_array(valid_email_array)
      end

    end
end
