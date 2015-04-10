api_dir = File.expand_path('../api', __FILE__)
Dir["#{api_dir}/**/*.rb"].sort.each do |file|
  require file
end
