module AutoMediaInfo
  class NoTransformer < StandardError; end
  
  def self.transform(url)
    if transform = determine_transformer_for_url(url)
      transformer.transform(url)
    else
      raise NoTransformer.new("No Transformer found for URL")
    end
  end
  
  def self.determine_transformer_for_url(url)
    transformer_classes.detect {|klass| klass.able_to_transform?(url)}
  end
  
  def self.transformer_classes
    @transformer_classes ||= [AutoMediaInfo::Transformer::Youtube]
  end
  
  def self.add_filter(name, &block)
    AutoMediaInfo::Builder.add_filter(name, &block)
  end
  
  def auto_media_info(raw, &proc)
    builder = Builder.new(raw)
    builder.instance_eval(&proc)
  end
end