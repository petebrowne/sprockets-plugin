require "sprockets/environment"

module Sprockets
  class Plugin
    module Aware
      # Overrides .new to append Plugin paths after
      # initialization. Is there a better way to do this?
      def new(root = ".")
        super(root) do |env|
          Plugin.plugins.each do |plugin|
            plugin.paths.each do |path|
              env.append_path path
            end
          end
        end
      end
    end
  end
end

Sprockets::Environment.extend Sprockets::Plugin::Aware
