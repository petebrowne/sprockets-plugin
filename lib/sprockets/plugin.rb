require "pathname"

module Sprockets
  class Plugin
    require "sprockets/plugin/version"
    
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
      def append_path(path)
        path = full_path(path)
        paths.push(path.to_s) if path.exist?
      end
      
      # Prepends a path to the Plugin. The path will
      # later be appended to the Sprockets::Environment.
      def prepend_path(path)
        path = full_path(path)
        paths.unshift(path.to_s) if path.exist?
      end
    
      # All of the paths registered by the plugin.
      def paths
        @paths ||= []
      end
      
      protected
      
      def full_path(path)
        path = Pathname.new(path)
        path = root.join(path) if root && path.relative?
        
        path.expand_path
      end
    end
  end
end
