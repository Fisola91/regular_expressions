require "marketing_campaign"

RSpec.describe "marketing campaign" do
  EMAILS = {
    "dimitri@lewagon" => false,
    "@lewagon" => false,
    "boris@lewagoncom" => false,
    "seb@lewagon.com" => true,
    "fisola@lewagon.com" => true,
    "charles@lewagon.com" => true,
    "dimitri@berlin.de" => true,
    "kevin@yahoo.fr" => true,
    "edward@gmail.fr" => true,
    "john@london.uk" => true,
    "peter@london.uk" => true
  }
  LOCALES = {
    uk: {
      subject: "Our website is online",
      body: "Come and visit us!",
      closing: "See you soon",
      signature: "The Team"
    },
    fr: {
      subject: "Notre site est en ligne",
      body: "Venez nous rendre visite !",
      closing: "A bientot",
      signature: "L'équipe"
    },
    de: {
      subject: "Unsere Website ist jetzt online",
      body: "Komm und besuche uns!",
      closing: "Bis bald",
      signature: "Das Team"
    }
  }

  let(:valid_email_array) {[]}

  context "when email is valid or invalid" do
    EMAILS.each do |email, result|
      status = result ? "valid" : "invalid"
      it "returns #{result ? true : false } for #{status} email" do
        expect(valid?(email)).to eq(result)
      end
    end
  end

  context "when valid emails" do
    let(:user) {{}}
    it "returns an array with valid emails only" do
      EMAILS.each do |email, result|
        valid_email_array << email if EMAILS[email] == true
      end
      expect(clean_database(EMAILS.keys)).to match_array(valid_email_array)
    end

    it "returns a Hash with the email addresses grouped by TLD" do
      EMAILS.each do |email, result|
        valid_email_array << email if EMAILS[email] == true
      end
      tld_grouped = valid_email_array.group_by do |email|
        email.split(".")[1]
      end
      expect(group_by_tld(EMAILS.keys)).to eq(tld_grouped)
    end

    it "returns a Hash of username, domain and TLD from the email" do
      EMAILS.each do |email, result|
        valid_email_array << email if EMAILS[email] == true
      end
      valid_email_array.each do |email|
        first_split = email.split("@")
        second_split = first_split[1].split(".")
        user[:username] = first_split[0]
        user[:domain] = second_split[0]
        user[:tld] = second_split[1]
      end
      expect(compose_email(EMAILS.keys)).to eq(user)
    end
  end

  context "when language translation" do
    let(:user) {{}}
    it "returns a Hash of user based on TLD" do
      EMAILS.each do |email, result|
        valid_email_array << email if EMAILS[email] == true
      end
      valid_email_array.each do |email|
        first_split = email.split("@")
        second_split = first_split[1].split(".")
        user[:username] = first_split[0]
        user[:domain] = second_split[0]
        user[:tld] = second_split[1]
      end
      LOCALES.each do |tld, index|
        if tld == user[:tld].to_sym
          index.each do |keywords, text|
            user[keywords] = text
          end
        end
      end
      expect(compose_translated_email).to eq(user)
    end
  end
end
