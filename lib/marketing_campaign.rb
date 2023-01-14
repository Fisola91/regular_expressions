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
    arrays = email.split("@").map do |pair|
      pair.split(".")
    end
    user["username"] = arrays[0][0]
    user["domain"] = arrays[1][0]
    user["tld"] = arrays[1][1]
  end
  user
end
