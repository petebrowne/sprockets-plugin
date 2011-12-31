require "sprockets/environment"

module Sprockets
  class Plugin
    module Aware
      def self.included(base)
        base.extend ClassMethods
      end
      
      module ClassMethods
        # Overrides .new to append Plugin paths after
        # initialization.
        #
        # Is there a better way to do this?
        def new(root = ".")
          super(root) do |env|
            env.append_plugin_paths
          end
        end
      end
      
      # Appends the paths from each Sprockets::Plugin
      # to the Sprockets::Environment.
      def append_plugin_paths
        Plugin.plugins.each do |plugin|
          plugin.paths.each do |path|
            self.append_path(path) unless self.paths.include?(path)
          end
        end
      end
    end
  end
end

Sprockets::Environment.send :include, Sprockets::Plugin::Aware
