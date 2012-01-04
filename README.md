sprockets-plugin
================

Package assets into gems for non-Rails Sprockets 2.x applications.


Installation
------------

``` bash
$ gem install sprockets-plugin
```


Usage in Applications
---------------------

To use Sprockets plugins, you only need to do 3 things:

1. Require "sprockets-plugin" to hook everything up.
   _This may be required by the plugins themselves, but it's best practice to also require this in your application._
2. Require any plugins you want to use.
3. Call Sprockets::Environment#append_plugin_paths after setting up your application paths.
   _Sprockets::Plugin **does not** automatically append paths to the environment. This is because the plugin paths would take precedence over your application's paths._
   
Here's an example:
   
``` ruby
require "sprockets"
require "sprockets-plugin" # 1.
require "my_plugin"        # 2.

map "/assets" do
  env = Sprockets::Environment.new
  env.append_path "assets/images"
  env.append_path "assets/javascripts"
  env.append_path "assets/stylesheets"
  env.append_plugin_paths # 3.
  run env
end
```

Usage in Gems
-------------

Sprockets::Plugin is meant to be used within gems, to package assets for reuse. Again, there's only 3 things to do to set this up.

1. Add it as a dependency in your gemspec.
2. Extend Sprockets::Plugin.
3. Add the necessary paths.

`my_plugin.gemspec`:

``` ruby
Gem::Specification.new do |s|
  # ...
  s.add_runtime_dependency "sprockets-plugin" # 1.
end
```

`my_plugin.rb`:

``` ruby
require "sprockets-plugin"

class MyPlugin < Sprockets::Plugin # 2.
  # Set the root path to use relative paths in `.append_path`
  root File.expand_path("../..", __FILE__)
  
  append_path "lib/assets/images"      # 3.
  append_path "lib/assets/javascripts" # 3.
  append_path "lib/assets/stylesheets" # 3.
end 
```


Copyright
---------

Copyright (c) 2011 [Peter Browne](http://petebrowne.com). See LICENSE for details.
