EMAIL_PATTERN = /\w+@\w+\.\w{3}/
def valid?(email)
  email.match?(EMAIL_PATTERN)
end

def clean_database(emails)
  valid_email = []
  emails.each do |email|
    if email =~ EMAIL_PATTERN
      valid_email << email
    end
  end
  valid_email
end
