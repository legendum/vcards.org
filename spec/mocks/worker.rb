class WorkerMock
  attr_accessor :jobs
  def initialize
    @jobs = []
  end

  def enqueue(klass, args, opts={})
    @jobs << DataStruct.new(
      klass: klass,
      args: args,
      opts: opts,
    )
  end
end

Thread.current[:worker] = WorkerMock.new
