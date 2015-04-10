class MailgunMessagesMock
  attr_accessor :sent
  def initialize
    @sent = []
  end
  def send_email(opts)
    @sent << opts
  end
end

class MailgunMock
  attr_accessor :messages
  def initialize
    @messages = MailgunMessagesMock.new
  end
end

Thread.current[:mailgun] = MailgunMock.new
