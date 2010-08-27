require 'rubygems'
require 'spec'
require 'active_merchant'
require 'mocha'
require 'nokogiri'

RAILS_ROOT = File.expand_path(File.join(File.dirname(__FILE__)))

require File.expand_path(File.join(File.dirname(__FILE__), '../', 'lib', 'active_merchant', 'billing', 'gateways', 'paypal_adaptive_payment.rb'))
Spec::Runner.configure do |config|
  config.mock_with :mocha
end