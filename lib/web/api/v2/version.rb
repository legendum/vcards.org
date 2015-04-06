module VCards
  module APIv2
    class Version < Grape::API

      version '2'
      format :json

      desc "Get the API version"
      get :version do
        {version: 2}
      end

      def self.class_list
        ObjectSpace.each_object(Class).select do |klass|
          klass.to_s =~ /^VCards::APIv2::/
        end
      end

    end
  end
end
