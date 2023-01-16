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

def translate(keyword, language)
  if LOCALES[language.to_sym].nil?
    translation = LOCALES[:uk]
  else
    translation = LOCALES[language.to_sym]
  end
  return translation[keyword]
end
