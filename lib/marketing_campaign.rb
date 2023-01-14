EMAIL_PATTERN = /\w+@\w+\.\w{2,3}/
def valid?(email)
  email.match?(EMAIL_PATTERN)
end

def clean_database(emails)
  valid_email = []
  emails.map do |email|
    valid_email << email if email.match?(EMAIL_PATTERN)
  end
  valid_email
end

def group_by_tld(emails)
  clean_database(emails).group_by do |email|
    email.split(".")[1]
  end
end

def compose_email(emails)
  user {}
  clean_database(emails).each do |email|
    first_split = email.split("@")
    second_split = first_split[1].split(".")
    user["username"] = first_split[0]
    user["domain"] = second_split[0]
    user["tld"] = second_split[1]
  end
  user
end
