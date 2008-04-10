begin
  require 'spec'
rescue LoadError
  require 'rubygems'
  gem 'rspec'
  require 'spec'
end

require File.dirname(__FILE__)+"/../tasks/header_to_rbi.rb"
require File.dirname(__FILE__)+'/../lib/bullet'

