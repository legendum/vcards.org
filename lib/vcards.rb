require "bundler"
Bundler.require(:default)

$LOAD_PATH.unshift(File.dirname(__FILE__))

module VCards

  def self.environment
    ENV["RACK_ENV"] || "development"
  end

  def self.development?
    environment == "development"
  end

  def self.production?
    environment == "production"
  end

  def self.test?
    environment == "test"
  end

  def self.cli?
    cmd = File.basename($0)
    cmd == "pry" || cmd == "rake"
  end

  def self.setup
    Dotenv.load # setup the env vars

    Dir["config/initializers/**/*.rb"].sort.each do |file|
      require_relative "../#{file}"
    end

    %w(concerns utils helpers models jobs).each do |dir|
      Dir["lib/#{dir}/**/*.rb"].sort.each do |file|
        require_relative "../#{file}"
      end
    end

    %w(app api admin).each do |server|
      require "web/#{server}"
    end
  end

end

# Make debugging easier with Pry
VCards.setup if $0 == 'pry'
