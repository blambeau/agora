module Agora
  class Config
    
    # Folder where the configuration is rooted
    attr_reader :root_folder 
    
    # Creates a configuration instance rooted to
    # some folder
    def initialize(root_folder)
      @root_folder = Pathname.new(root_folder)
    end
    
    # Finds and build a Config instance by locating
    # .agora in one of root's self-or-ancestors
    def self.find(root = '.')
      root = Pathname.new(root).expand_path unless root.is_a?(Pathname)
      if (root + ".agora").file?
        return Config.new(root)
      elsif (root.parent.exist? and root.parent != root)
        find(root.parent)
      else
        raise "Unable to find a .agora file from #{root}"
      end
    end
    
  end # class Config
end # module Agora