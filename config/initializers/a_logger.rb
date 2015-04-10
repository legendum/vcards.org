module VCards
  def self.logger
    Thread.current[:logger] ||= Logger.new("log/#{environment}.log")
  end
end
