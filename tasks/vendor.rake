require 'rubygems'
require 'pmsrb'

include PMS

desc "Update the vendor headers/lib for bullet"
namespace :vendor do
  work = File.dirname(__FILE__)+"/../tmp"
  
  desc "Downloads the latest bullet library"
  task :download do
    PMS::vendor do
      FileUtils.mkdir_p work 
      working_directory work
      if Platform.windows?
        download "http://bullet.googlecode.com/files/bullet-#{Bulletrb::VERSION::VENDOR}.zip"
      else
        download "http://bullet.googlecode.com/files/bullet-#{Bulletrb::VERSION::VENDOR}.tgz"
      end
      extract
    end
  end
  
  desc "Builds the latest bullet library"
  task :build do
    PMS::vendor do
      working_directory work
      cd "bullet-2.68"
      unless(Platform.mac?)
        build "./configure", "jam"
      else
        build "cmake . -G Xcode", "xcodebuild"
      end
    end
  end
  
  desc "Clean the downloaded bullet library"
  task :clean do
    FileUtils.mkdir_p work
    FileUtils.rm_r work
  end
  
  task :update => [:clean, :download, :build]
  task :default => :update  
end
