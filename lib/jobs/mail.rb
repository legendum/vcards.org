module VCards
  module Jobs
    class Mail
      include Backburner::Queue
      queue "mail"
      queue_priority 1000
      queue_respond_timeout 180

      # The opts should include:
      # :from
      # :to
      # :subject
      # :text
      # :html
      # :mail (optional name of the mail template to use)
      # ...and the params go into the text and html
      def self.perform(opts, params={})
        VCards.mailer.send(opts, params)
      rescue Exception => error
        notify error
        raise error.message # to bury the job
      end
    end
  end
end
