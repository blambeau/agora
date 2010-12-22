module Agora
  class Config
    
    # Folder where the configuration is rooted
    attr_reader :root_folder 
    
    # Creates a configuration instance rooted to
    # some folder
    def initialize(root_folder)
      @root_folder = Pathname.new(root_folder)
    end
    
    # Finds current folder or one of its ancestors
    # that contains a .agora file. Returns a Pathname
    # instance
    def self.find_folder(root = '.')
      if !root.is_a?(Pathname)
        find_folder(Pathname.new(root).expand_path)
      elsif (root + ".agora").file?
        root
      elsif (root.parent.exist? and root.parent != root)
        find_folder(root.parent)
      else
        raise "Unable to find a .agora file from #{root}"
      end
    end
    
    # Loads a configuration instance from a root folder.
    # root_folder must be a Pathname instance and be such
    # that a .agora file exists
    def self.load(root_folder = find_folder)
      dot_agora = (root_folder + '.agora')
      cfg = Config.new(root_folder)
      cfg.instance_eval(dot_agora.read, dot_agora.to_s)
      cfg
    end
    
    # Convenient helper for load(find_folder(root))
    def self.find(root = '.')
      Config.load(find_folder(root))
    end
    
  end # class Config
end # module Agora