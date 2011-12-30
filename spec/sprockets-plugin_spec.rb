require "spec_helper"

describe Sprockets::Plugin do
  after :each do
    Sprockets::Plugin.class_variable_set :@@plugins, nil
  end
  
  describe ".append_path" do
    it "adds paths" do
      dir1 = @sandbox.directory "plugin/assets/images"
      dir2 = @sandbox.directory "plugin/assets/javascripts"
      dir3 = @sandbox.directory "plugin/assets/stylesheets"
      
      plugin = Class.new Sprockets::Plugin
      plugin.append_path dir1
      plugin.append_path dir2
      plugin.append_path dir3
      plugin.paths.should == [dir1, dir2, dir3].map(&:to_s)
    end
    
    it "adds the paths relative to the plugin root" do
      dir1 = @sandbox.directory "plugin/assets/images"
      dir2 = @sandbox.directory "plugin/assets/javascripts"
      dir3 = @sandbox.directory "plugin/assets/stylesheets"
      
      plugin = Class.new Sprockets::Plugin
      plugin.root @sandbox.join "plugin"
      plugin.append_path "assets/images"
      plugin.append_path "assets/javascripts"
      plugin.append_path "assets/stylesheets"
      plugin.paths.should == [dir1, dir2, dir3].map(&:to_s)
    end
    
    it "only adds existing paths" do
      dir1 = @sandbox.directory "plugin/assets/images"
      dir2 = @sandbox.directory "plugin/assets/javascripts"
      dir3 = @sandbox.join "plugin/assets/stylesheets"
      
      plugin = Class.new Sprockets::Plugin
      plugin.append_path dir1
      plugin.append_path dir2
      plugin.append_path dir3
      plugin.paths.should == [dir1, dir2].map(&:to_s)
    end
  end
  
  describe ".prepend_path" do
    it "adds paths" do
      dir1 = @sandbox.directory "plugin/assets/images"
      dir2 = @sandbox.directory "plugin/assets/javascripts"
      dir3 = @sandbox.directory "plugin/assets/stylesheets"
      
      plugin = Class.new Sprockets::Plugin
      plugin.prepend_path dir1
      plugin.prepend_path dir2
      plugin.prepend_path dir3
      plugin.paths.should == [dir3, dir2, dir1].map(&:to_s)
    end
    
    it "adds the paths relative to the plugin root" do
      dir1 = @sandbox.directory "plugin/assets/images"
      dir2 = @sandbox.directory "plugin/assets/javascripts"
      dir3 = @sandbox.directory "plugin/assets/stylesheets"
      
      plugin = Class.new Sprockets::Plugin
      plugin.root @sandbox.join "plugin"
      plugin.prepend_path "assets/images"
      plugin.prepend_path "assets/javascripts"
      plugin.prepend_path "assets/stylesheets"
      plugin.paths.should == [dir3, dir2, dir1].map(&:to_s)
    end
    
    it "only adds existing paths" do
      dir1 = @sandbox.directory "plugin/assets/images"
      dir2 = @sandbox.directory "plugin/assets/javascripts"
      dir3 = @sandbox.join "plugin/assets/stylesheets"
      
      plugin = Class.new Sprockets::Plugin
      plugin.prepend_path dir1
      plugin.prepend_path dir2
      plugin.prepend_path dir3
      plugin.paths.should == [dir2, dir1].map(&:to_s)
    end
  end
  
  describe ".root" do
    it "converts the given path to a Pathname object" do
      plugin_path = @sandbox.join "plugin"
      plugin = Class.new Sprockets::Plugin
      plugin.root plugin_path.to_s
      plugin.root.should be_an_instance_of(Pathname)
      plugin.root.should == plugin_path
    end
  end
  
  describe ".plugins" do
    it "returns all of the plugins" do
      plugin_1 = Class.new Sprockets::Plugin
      plugin_2 = Class.new Sprockets::Plugin
      plugin_3 = Class.new Sprockets::Plugin
      Sprockets::Plugin.plugins.should == [ plugin_1, plugin_2, plugin_3 ]
    end
  end
end
