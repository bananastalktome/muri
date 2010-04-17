class Muri

  protected

  def self.fetch_xml(url)    
    xml = Net::HTTP.get_response(URI.parse(url)).body
    doc = REXML::Document.new(xml)
    raise if doc.is_a?(String) #meaning error...
    doc
  end

end
