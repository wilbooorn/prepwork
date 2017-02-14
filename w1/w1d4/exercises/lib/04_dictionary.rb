class Dictionary
  attr_accessor :entries

  def initialize(entries = {})
    @entries = entries
  end
  
  def entries
    @entries
  end
  
  def add(entry)
    if entry.is_a?(String)
      @entries[entry] = nil
    else
      @entries = @entries.merge(entry)
    end
  end
  
  def keywords
    @entries.keys.sort
  end
  
  def include?(keyword)
    @entries.key?(keyword)
  end
  
  def find(keyword)
    @entries.select { |k, v| k.include?(keyword) }
  end
  
  def printable
    result = ""
    keys = keywords
    keys.each do |key|
      result << "[#{key}] " << "\"" <<  "#{entries[key]}" << "\""
      result << "\n" unless key == keys[-1]
    end
    result
  end

end
