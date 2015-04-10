module VCards
  def self.worker
    Thread.current[:worker] ||= Backburner::Worker
  end
end
