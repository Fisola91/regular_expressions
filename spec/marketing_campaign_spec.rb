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
    "john@london.uk" => true,
    "peter@london.uk" => true,
    "edward@gmail.fr" => true
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

  context "when email is valid or invalid" do
    EMAILS.each do |email, result|
      status = result ? "valid" : "invalid"
      it "returns #{result ? true : false } for #{status} email" do
        expect(valid?(email)).to eq(result)
      end
    end
  end

  context "when valid emails" do
    it "returns an array with valid emails only" do
      valid_email_array =
        [
          "seb@lewagon.com",
          "fisola@lewagon.com",
          "charles@lewagon.com",
          "dimitri@berlin.de",
          "kevin@yahoo.fr",
          "john@london.uk",
          "peter@london.uk",
          "edward@gmail.fr"
        ]
      expect(clean_database(EMAILS.keys)).to match_array(valid_email_array)
    end

    it "returns a Hash with the email addresses grouped by TLD" do
      tld_grouped = {
        "com"=>["seb@lewagon.com", "fisola@lewagon.com", "charles@lewagon.com"],
        "de"=>["dimitri@berlin.de"],
        "fr"=>["kevin@yahoo.fr", "edward@gmail.fr"],
        "uk"=>["john@london.uk", "peter@london.uk"]
      }
      expect(group_by_tld(EMAILS.keys)).to eq(tld_grouped)
    end

    it "returns a Hash of username, domain and TLD from the email" do
      expect(compose_email("seb@lewagon.fr")).to eq({ username: "seb", domain: "lewagon", tld: "fr" })
      expect(compose_email("dimitri@lewagon.de")).to eq({ username: "dimitri", domain: "lewagon", tld: "de"})
    end
  end

  context "when language translation" do
    it "should return a Hash with the message informations in french for a `.fr` mail" do
      email = compose_translated_email("edward@gmail.fr")
      expected = {
        username: "edward",
        domain: "gmail",
        tld: "fr",
        subject: "Notre site est en ligne",
        body: "Venez nous rendre visite !",
        closing: "A bientot",
        signature: "L'équipe"
      }
      expect(email).to eq(expected)
    end

    it "should return a Hash with the message informations in english for a `.uk` mail" do
      email = compose_translated_email("john@london.uk")
      expected = {
        username: "john",
        domain: "london",
        tld: "uk",
        subject: "Our website is online",
        body: "Come and visit us!",
        closing: "See you soon",
        signature: "The Team"
      }
      expect(email).to eq(expected)
    end

    it "should return a Hash with the message informations in english for a `.de` mail" do
      email = compose_translated_email("dimitri@berlin.de")
      expected = {
        username: "dimitri",
        domain: "berlin",
        tld: "de",
        subject: "Unsere Website ist jetzt online",
        body: "Komm und besuche uns!",
        closing: "Bis bald",
        signature: "Das Team"
      }
      expect(email).to eq(expected)
    end
  end
end
