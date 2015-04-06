require_relative "./base"

module VCards
  class Admin < Base

    set :views, Proc.new { File.join(root, "admin", "views") }

    assets do
      # Images
      serve "/images", from: "admin/images"

      # JavaScript and CoffeeScript
      serve "/scripts", from: "admin/scripts"
      js :admin, '/scripts/admin.js', ['/scripts/**/*.js']
      js_compression :uglify

      # CSS
      serve "/styles", from: "admin/styles"
      css :admin, '/styles/admin.css', ['/styles/**/*.css']
      css_compression :sass

      # Generate production assets to allow for fast caching
      prebuild(VCards.production? && !VCards.cli?)
    end

    # Setup routes via the controller
    require_relative "admin/controller"
    Controller.draw_routes(self)
  end
end
