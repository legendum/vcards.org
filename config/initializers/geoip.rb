module VCards
  def self.geoip(ip)
    path = File.expand_path("../../../db/geoip/GeoLiteCity.dat", __FILE__)
    GeoIP.new(path).country(ip)
  end
end
