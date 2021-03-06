require 'pathname'

module Sprockets
  class Plugin
    require 'sprockets/plugin/version'
    require 'sprockets/plugin/aware'
    
    class << self
      def inherited(plugin)
        plugins << plugin
      end
      
      # Returns all of the plugins inheriting from
      # Sprockets::Plugin.
      def plugins
        @@plugins ||= []
      end
      
      # Sets the root path or returns the current one.
      # A root path is required for appending relative
      # paths.
      def root(path = nil)
        if path
          @root = Pathname.new(path).expand_path
        else
          @root
        end
      end
      
      # Appends a path to the Plugin. The path will
      # later be appended to the Sprockets::Environment.
      def append_paths(*paths)
        self.paths.push *normalize_paths(paths)
        self
      end
      alias_method :append_path, :append_paths
      
      # Append each path in the given directory.
      def append_paths_in(path)
        path = normalize_path(path)
        append_paths(*path.children.select(&:directory?)) if path.directory?
        self
      end
    
      # All of the paths registered by the plugin.
      def paths
        @paths ||= []
      end
      
      protected
      
      def normalize_path(path)
        Pathname.new(path).expand_path(root)
      end
      
      def normalize_paths(paths)
        normalized_paths = []
        paths.each do |path|
          path = normalize_path(path)
          normalized_paths.push(path.to_s) if path.exist?
        end
        normalized_paths
      end
    end
  end
end
