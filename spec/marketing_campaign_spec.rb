require "marketing_campaign"

RSpec.describe "marketing campaign" do
  EMAILS = {
    "dimitri@lewagon" => false,
    "@lewagon" => false,
    "boris@lewagoncom" => false,
    "seb@lewagon.com" => true,
    "fisola@lewagon.com" => true,
    "charles@lewagon.com" => true
  }
  context "when email is valid or invalid" do
    EMAILS.each do |email, result|
      outcome = result ? "valid" : "invalid"
      it "returns #{result ? true : false } for #{outcome} email" do
        expect(valid?(email)).to eq(result)
      end
    end
  end

  context "when array of valid emails" do
    let(:valid_email_array) {[]}
    it "returns an array with valid emails only" do
      EMAILS.each do |email, result|
        valid_email_array << email if EMAILS[email] == true
      end
      expect(clean_database(EMAILS.keys)).to match_array(valid_email_array)
    end
  end
end
