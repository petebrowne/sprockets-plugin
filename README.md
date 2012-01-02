sprockets-plugin
================

Package assets into gems for non-Rails applications.


Installation
------------

``` bash
$ gem install sprockets-plugin
```


Usage
-----

Sprockets::Plugin is meant to be used within gems, to package assets for reuse. So the first step is to add it as a dependency in your gemspec:

``` ruby
Gem::Specification.new do |s|
  # ...
  s.add_runtime_dependency "sprockets-plugin"
end
```

And then extend Sprockets::Plugin and add the necessary asset paths:

``` ruby
require "sprockets-plugin"

class MyPlugin < Sprockets::Plugin
  # Set the root path to use relative paths in `.append_path`
  root File.expand_path("../..", __FILE__)
  append_path "lib/assets/images"
  append_path "lib/assets/javascripts"
  append_path "lib/assets/stylesheets"
end 
```

Now any assets in the "lib/assets" directory will be available to applications that require this gem:

``` ruby
require "sprockets"
require "my_plugin"

map "/assets" do
  environment = Sprockets::Environment.new
  # The assets from MyPlugin will be automatically appended.
  environment.append_path "assets/images"
  environment.append_path "assets/javascripts"
  environment.append_path "assets/stylesheets"
  run environment
end
```

Advanced Usage
--------------

You can package assets for Rails and non-Rails applications in the following way:

``` ruby
if defined? Rails
  require "my_assets/engine"
elsif defined? Sprockets::Plugin
  require "my_assets/plugin"
end
```

Copyright
---------

Copyright (c) 2011 [Peter Browne](http://petebrowne.com). See LICENSE for details.
