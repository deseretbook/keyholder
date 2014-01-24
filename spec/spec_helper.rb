$LOAD_PATH.unshift './lib'

require 'keyholder'

require 'rubygems'
require 'spork'

require 'test/unit'

Spork.prefork do
  ENV["RAILS_ENV"] = 'test'
  require 'webmock/rspec'

  RSpec.configure do |config|
    config.mock_with :rspec
    config.order = 'random'
  end
end
