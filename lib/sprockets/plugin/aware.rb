require "sprockets/environment"

module Sprockets
  class Plugin
    module Aware
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
