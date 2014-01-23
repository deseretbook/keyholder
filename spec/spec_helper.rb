$LOAD_PATH.unshift './lib'

require 'sesame'

require 'rubygems'
require 'spork'

require 'test/unit'
include Test::Unit::Assertions

Spork.prefork do
  ENV["RAILS_ENV"] = 'test'
  require 'webmock/rspec'

  RSpec.configure do |config|
    # == Mock Framework
    config.mock_with :rspec
    config.order = 'random'
  end
end
