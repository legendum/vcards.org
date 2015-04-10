module VCards
  def self.email_address(key, brand=nil)
    brand ||= VCards.brands.default
    email = VCards.brands[brand][:email]
    assert email, "no email addresses have been setup for brand #{brand}"
    address = email[key.to_sym]
    assert address, "can't find an email address for :#{key} for brand #{brand}"
    address
  end
end
