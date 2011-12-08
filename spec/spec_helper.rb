require "sprockets"
require "sprockets-plugin"
require "construct"

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  include Construct::Helpers
  
  config.before :each do
    @sandbox = create_construct
  end
  
  config.after :each do
    @sandbox.destroy!
  end
end
