$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rubygems'
require 'rr'
gem "minitest", "4.7.5"
require 'test/unit'

if ENV['SIMPLE_COV']
  require 'simplecov'
  SimpleCov.start do 
    add_filter 'test/'
    add_filter 'pkg/'
    add_filter 'vendor/'
  end
end
