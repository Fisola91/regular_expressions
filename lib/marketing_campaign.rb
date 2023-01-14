def valid?(email)
  email.match?(/\w+@\w+\.\w{3}/)
end
