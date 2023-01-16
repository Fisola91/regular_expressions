EMAIL_PATTERN = /\w+@\w+\.\w{2,3}/
def valid?(email)
  email.match?(EMAIL_PATTERN)
end

def clean_database(emails)
  emails.select do |email|
    email if email.match?(EMAIL_PATTERN)
  end
end

def group_by_tld(emails)
  clean_database(emails).group_by do |email|
    email.split(".")[1]
  end
end

def compose_email(emails)
  user = {}
  clean_database(emails).each do |email|
    user_info(user, email)
  end
  user
end

def compose_translated_email(emails)
  compose_email(emails)
  LOCALES.each do |tld, info|
    if tld == user[:tld].to_sym
      info.each do |keywords, text|
        user[keywords] = text
      end
    end
  end
  user
end

private

def user_info(user, email)
  arrays = email.split("@").map do |pair|
    pair.split(".")
  end
  user[:username] = arrays[0][0]
  user[:domain] = arrays[1][0]
  user[:tld] = arrays[1][1]
end
