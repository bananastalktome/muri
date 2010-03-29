class Muri

  protected

  def self.param_parse(query)
    return { } if query.nil?
    params_flat = { }
    params = CGI::parse(query)
    params.each {|k,v| params_flat[k] = v.first}
    params_flat
  end

end
