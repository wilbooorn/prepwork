class XmlDocument
  attr_reader :indents
  
  def initialize(indents = false)
    @indents = indents
  end
  
  def hello(options = {})
    str = ""
    defaults = {
      name: ""
    }
    if block_given?
      @indents ? str <<"<hello>\n" : str <<"<hello>"
      str << yield
      @indents ? str <<"</hello>\n" : str <<"</hello>"
    else
      options = defaults.merge(options)
      if options[:name].empty?
        str = "<hello/>"
      else
        str = "<hello name=\"#{ options[:name]}\"/>"
      end
    end
    str
  end
  
  def send(tag)
    str = "<#{ tag }/>"
  end
  
  def method_missing(*args)
    method_name = args[0]
    options = args[1] if args.length > 1
    str = ""
    
    if @indents
      if block_given?
        str <<"<#{ method_name }>\n"
        str << yield
        str << "</#{ method_name }>\n"
      else
        if options
          str = "<#{ method_name } #{ options.keys[0].to_s }=\"#{ options.values[0].to_s}\"/>\n"
        else
          str = "<#{ method_name }/\n>"
        end
      end
    else
      if block_given?
        str <<"<#{ method_name }>"
        str << yield
        str << "</#{ method_name }>"
      else
        if options
          str = "<#{ method_name } #{ options.keys[0].to_s }=\"#{ options.values[0].to_s}\"/>"
        else
          str = "<#{ method_name }/>"
        end
      end
    end
    
    if @indents
      str = indent(str)
    end
    str
  end
  
  def indent(str)
    result = ""
    arr = str.split("\n").map { |elem| elem.concat("\n") }
    arr.each { |item| result << ("  ") << item }
    result
  end
  
end
