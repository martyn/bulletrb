require 'rubygems'
require 'pmsrb'
require File.join(File.dirname(__FILE__),'..','lib','bulletrb','version')

task :extension do
  unless Platform.linux?
    Rake::Task['vendor:download_extensions'].invoke
  else
    Rake::Task['vendor:update'].invoke
    Rake::Task['build:rebuild'].invoke
    Rake::Task['vendor:clean'].invoke
  end
end
