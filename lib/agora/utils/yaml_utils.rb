module Agora
  module YAMLUtils
    
    # 
    # Merges a left and right object recursively and returns
    # result.
    # 
    def merge(left, right)
      unless left.class == right.class
        raise "Unexpected case #{left.class} vs. #{right.class}"
      end
      case left
        when Array
          (left + right).uniq
        when Hash
          left.merge(right){|key,leftv,rightv|
            merge(leftv,rightv)
          }
        else
          if left==right
            left
          else
            raise "Conflict on #{left} and #{right}"
          end
      end
    end
    
    # 
    # Loads a YAML document, load and merge sub documents 
    # identified by _resolver_ if options[:recurse] is set 
    # to true
    #
    def file_load(file, options = {}, &resolver)
      # load YAML brut result
      loaded = YAML::load(File.read(file))
      
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