module VCards
  module APIv1
    class Version < Grape::API

      version '1'
      format :json

      desc "Get the API version"
      get :version do
        {version: 1}
      end

      def self.class_list
        ObjectSpace.each_object(Class).select do |klass|
          klass.to_s =~ /^VCards::APIv1::/
        end
      end

    end
  end
end
