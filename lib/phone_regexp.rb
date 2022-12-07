FRENCH_PHONE_PATTERN = /^(\+33|0)(\s|[1-9])([-| ]*\d{1}){8,}$/
def french_phone_number?(phone_number)
  phone_number.match?(FRENCH_PHONE_PATTERN)
end
