module VCards

  class Controller
    def self.draw_routes(app)

      app.class_eval do

        # Cookie warning coz we're UK-based

        before do
          unless cookies['acceptCookies'] == 'yes'
            flash.now[:notice] = 'This website uses cookies - see details <a href="/legal#cookies">here</a>'
            flash.now[:action] = 'cookie' # for FlashCtrl in script/basic/app.js
          end
        end


        # Welcome pages

        get "/" do
          parse_erb :index
        end


        # Auth handlers

        get "/auth/failure" do
          @title = "Oops!"
          logger.warn (flash[:notice] = params[:message])
          redirect "/"
        end

        %w[get post].each do |method|
          send(method, "/auth/:provider/callback") do
            user = session[:user_id] ? User.find(session[:user_id]) : nil
            if auth = Auth.setup_for(params[:provider], env["omniauth.auth"], user, session)
              redirect "/profile" if session[:user_id] # (coz we were logged in)
              session[:user_id] = auth.user.id
              if auth.created_at > 10.seconds.ago
                redirect "/welcome/setup"
              else
                redirect "/dashboard"
              end
            else
              logger.warn (flash[:notice] = "Something went wrong")
              redirect "/"
            end
          end
        end

      end
    end
  end
end
