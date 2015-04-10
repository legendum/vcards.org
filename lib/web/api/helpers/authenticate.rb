module VCards
  module API
    module Helpers

      module Authenticate
        include Authenticated   # for "authenticate!" and "current_user" methods
                                # (see "lib/concerns/authenticate.rb" for logic)
        def session
          env['rack.session']
        end
      end

    end
  end
end
