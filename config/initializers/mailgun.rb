Mailgun.configure do |config|
  config.api_key = ENV["MAILGUN_API_KEY"] or abort "please set MAILGUN_API_KEY"
  config.domain  = ENV["MAILGUN_DOMAIN"]  or abort "please set MAILGUN_DOMAIN"
end

module VCards
  def self.mailgun
    Thread.current[:mailgun] ||= Mailgun()
  end
end
