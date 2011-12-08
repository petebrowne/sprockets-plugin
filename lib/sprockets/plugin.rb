require "pathname"

module Sprockets
  class Plugin
    require "sprockets/plugin/version"
    
    class << self
      #
      attr_reader :root
      
      #
      def root=(path)
        @root = Pathname.new(path).expand_path
      end
      
      #
      def append_path(path)
        path = full_path(path)
        paths.push(path.to_s) if path.exist?
      end
      
      #
      def prepend_path(path)
        path = full_path(path)
        paths.unshift(path.to_s) if path.exist?
      end
    
      #
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
