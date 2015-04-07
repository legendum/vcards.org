class Queue
  include EnqueueJobs

  def id; nil; end

  def self.enqueue(job_class, *args)
    delay = block_given? ? yield : 0
    @@queue ||= Queue.new
    @@queue.enqueue(job_class, *args) { delay }
  end
end
