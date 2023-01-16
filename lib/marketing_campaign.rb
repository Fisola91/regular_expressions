EMAIL_PATTERN = /\w+@\w+\.\w{2,3}/
def valid?(email)
  email.match?(EMAIL_PATTERN)
end

def clean_database(emails)
  emails.select {|email| valid?(email) }
end

def group_by_tld(emails)
  clean_database(emails).group_by do |email|
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

def compose_translated_email(emails)
  compose_email(emails)
  LOCALES.each do |tld, info|
    if tld == user[:tld]
      info.each do |keywords, text|
        user[keywords] = text
      end
    end
  end
  user
end
