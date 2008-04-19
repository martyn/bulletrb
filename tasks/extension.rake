require 'rubygems'
require 'pmsrb'
require File.join(File.dirname(__FILE__),'..','lib','bulletrb','version')

task :extension do
  unless Platform.linux?
    # In our extension, we grab the binaries from our website.
    vendor do
      working_directory File.join(File.dirname(__FILE__),'..','lib','cpp')
      download "http://shatteredruby.com/vendor/bullet-extensions-#{BulletRB::VERSION::STRING}-#{Platform.short_name}.zip"
      extract
    end
  else
    Rake::Task['vendor:update'].invoke
    Rake::Task['build:rebuild'].invoke
    Rake::Task['vendor:clean'].invoke
  end
end
