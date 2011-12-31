require "pathname"

module Sprockets
  class Plugin
    require "sprockets/plugin/version"
    require "sprockets/plugin/aware"
    
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
      end
      alias_method :append_path, :append_paths
      
      # Prepends a path to the Plugin. The path will
      # later be appended to the Sprockets::Environment.
      def prepend_paths(*paths)
        self.paths.unshift *normalize_paths(paths)
      end
      alias_method :prepend_path, :prepend_paths
    
      # All of the paths registered by the plugin.
      def paths
        @paths ||= []
      end
      
      protected
      
      def normalize_paths(paths)
        paths.inject([]) do |normalized_paths, path|
          path = Pathname.new(path)
          path = root.join(path) if root && path.relative?
          path = path.expand_path
          normalized_paths.push(path.to_s) if path.exist?
        end
      end
    end
  end
end
