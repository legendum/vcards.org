module VCards
  class Controller
    def self.draw_routes(app)
      app.class_eval do

        get "/" do
          erb :index
        end

        get "/users" do
          users = User.includes(:auths).sort_by {|u| u.email}
          erb :users, locals: {users: users}
        end

        # Test methods

        get "/test/page" do
          erb :test
        end

        get "/test/mail" do
          opts = {
            from: VCards.email_address(:sender),
            to: VCards.email_address(:admin),
            subject: "test email",
            mail: :welcome,
          }
          VCards.mailer.send(opts, name: "Kevin")
        end

        not_found do
          erb :not_found
        end
      end
    end
  end
end
