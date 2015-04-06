require "sinatra/base"

module VCards
  class Base < Sinatra::Application
    def logger; VCards.logger; end # to override the default STDOUT logger

    def parse_erb(file, opts={})
      brand = VCards.brands.hosts[request.host] ||
              VCards.brands.default
      erb file, layout: :"layouts/#{brand}", locals: opts
    end

    set :root, File.dirname(__FILE__)
    set :database_file, "../../config/database.yml"

    # Handle errors gracefully
    set :dump_errors, true
    error StandardError do
      error = env['sinatra.error']
      notify error unless error.is_a? Sinatra::NotFound
    end

    # Setup sessions
    abort "Please set SESSION_SECRET in .env" unless ENV["SESSION_SECRET"]
    use Rack::Session::Cookie, secret: ENV["SESSION_SECRET"]

    # Setup assets
    require "sinatra/assetpack"
    register Sinatra::AssetPack
    set :reload_templates, !VCards.production?

    # Setup cookies
    require "sinatra/cookies"
    register Sinatra::Cookies

    # Setup flash messages
    require "sinatra/flash"
    register Sinatra::Flash

    # Setup web partials
    require "sinatra/partial"
    register Sinatra::Partial
    set :partial_template_engine, :erb
  end
end
