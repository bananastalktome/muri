class Muri

  protected

  def self.param_parse(query)
    params_flat = { }
    params = CGI::parse(query)
    params.each {|k,v| params_flat[k] = v.first}
    params_flat
  end

  #used by flickr. Ported from PHP.
  def self.decode58(str)
    decoded = 0
    multi = 1
    alphabet = "123456789abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ"
    while str.length > 0
      digit = str[(str.length - 1),1]
      decoded += multi * alphabet.index(digit)
      multi = multi * alphabet.length
      str.chop!
    end

    decoded
  end

  #used by flickr. Ported from PHP.
  def self.encode58(str)
    alphabet = "123456789abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ"
    base_count = alphabet.length
    encoded = ''
    while str >= base_count
      div = str / base_count
      mod = (str-(base_count * div))
      encoded = alphabet[mod,1] + encoded
      str = div
    end
    encoded = (alphabet[str,1] + encoded) if str
    encoded
  end
end
