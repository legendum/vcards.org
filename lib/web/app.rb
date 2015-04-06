require_relative "./base"

module VCards
  class App < Base
    include Authenticated # for "authenticate!" and "current_user" methods

    set :views, Proc.new { File.join(root, "app", "views") }
    set :public_folder, Proc.new { File.join(root, "app", "public") } 

    assets do
      # Images
      serve "/images", from: "app/images"

      # JavaScript and CoffeeScript
      serve "/scripts", from: "app/scripts"
      js :app_basics, '/scripts/app_basics.js', ['/scripts/basic/**/*.js']
      js :app_extras, '/scripts/app_extras.js', ['/scripts/extra/**/*.js']
      js_compression :uglify

      # CSS
      serve "/styles", from: "app/styles"
      css :app_basics, '/styles/app_basics.css', ['/styles/basic/**/*.css']
      css :app_extras, '/styles/app_extras.css', ['/styles/extra/**/*.css']
      css_compression :sass

      # Generate production assets to allow for fast caching
      prebuild(VCards.production? && !VCards.cli?)
    end

    # Setup OAuth connectors
    use OmniAuth::Builder do
      VCards.integrations.each do |provider_sym, env_var_names|
        env_vars = []
        env_var_names.each do |var_name|
          abort "Please set env var #{var_name} in .env" unless ENV[var_name]
          env_vars << ENV[var_name]
        end
        options = VCards.integration_options[provider_sym] || {}
        provider provider_sym, *env_vars, options
      end
    end

    # Setup routes via the controller
    require_relative "app/controller"
    Controller.draw_routes(self)
  end
end
