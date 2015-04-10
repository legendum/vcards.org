class Zipper
  def self.zip(data)
    io = StringIO.new('w')
    gz = Zlib::GzipWriter.new(io)
    gz.write(data)
    gz.close
    io.string
  end

  def self.unzip(data)
    io = StringIO.new(data, 'rb')
    gz = Zlib::GzipReader.new(io)
    data = gz.read
    gz.close
    data
  end
end
