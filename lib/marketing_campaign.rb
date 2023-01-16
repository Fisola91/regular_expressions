class MarketingCampaign
  EMAIL_PATTERN = /\w+@\w+\.\w{2,3}/
  def initialize(emails)
    @emails = emails
  end

  def valid?(email)
    email.match?(EMAIL_PATTERN)
  end

  def clean_database
    emails.select {|email| valid?(email) }
  end

  def group_by_tld
    clean_database.group_by do |email|
      email.match(/\.(\w+)$/)[1]
    end
  end

  def compose_email(email)
    match_data = email.match(/^(?<name>\w+)@(?<domain>\w+).(?<tld>\w+)$/)
    return {
      username: match_data[:name],
      domain: match_data[:domain],
      tld: match_data[:tld]
    }
  end

  def compose_translated_email(email)
    match_data = email.match(/^(?<name>\w+)@(?<domain>\w+).(?<tld>\w+)$/)
    return {
      username: match_data[:name],
      domain: match_data[:domain],
      tld: match_data[:tld],
      subject: translate(:subject, match_data[:tld]),
      body: translate(:body, match_data[:tld]),
      closing: translate(:closing, match_data[:tld]),
      signature: translate(:signature, match_data[:tld])
    }
  end

  private
  attr_reader :emails

  def translate(keyword, language)
    translation = LOCALES[language.to_sym]
    return translation[keyword]
  end
end
