module Agora
  module YAMLUtils
    
    # 
    # Merges a left and right object recursively and returns
    # result.
    # 
    def merge(left, right)
      raise "Unexpected case #{left.class} vs. #{right.class}" unless left.class==right.class
      case left
      when Array then (left + right).uniq
      when Hash  then left.merge(right){|_,lv,rv| merge(lv,rv) }
      else
        raise "Conflict on #{left} and #{right}" unless left==right
        left
      end
    end
    
    # 
    # Loads a YAML document, load and merge sub documents 
    # identified by _resolver_ if options[:recurse] is set 
    # to true
    #
    def file_load(file, options = {}, &resolver)
      file   = Path(file).expand
      loaded = YAML.load file.read
      
      # mark as loaded
      (options[:loaded] ||= []) << file
      return loaded unless options[:recursive]
      
      # recurse on extra documents
      if extras = resolver.call(file, loaded, options)
        extras.each do |extra|
          # bypass already loaded documents
          next if options[:loaded].include?(extra)
          
          # recurse and merge
          extra_loaded = file_load(extra, options, &resolver)
          loaded = merge(loaded, extra_loaded)
        end
      end
      loaded
    end
    
    extend YAMLUtils
  end # class YAMLUtils
end # module Agora