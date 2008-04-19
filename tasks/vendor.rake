require 'rubygems'
require 'pmsrb'

include PMS

desc "Update the vendor headers/lib for bullet"
namespace :vendor do
  work = File.dirname(__FILE__)+"/../tmp"
<<<<<<< HEAD:tasks/vendor.rake
  
  desc "Downloads the latest bullet library"
=======

  desc "Download the bullet SDK from google code."
>>>>>>> e167682624e4354922dd00960c7dc7c967a05d85:tasks/vendor.rake
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
  
<<<<<<< HEAD:tasks/vendor.rake
  desc "Builds the latest bullet library"
=======
  desc "Build the downloaded bullet SDK."
>>>>>>> e167682624e4354922dd00960c7dc7c967a05d85:tasks/vendor.rake
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
  
<<<<<<< HEAD:tasks/vendor.rake
  desc "Clean the downloaded bullet library"
=======
  #desc "Upload the built, platform-specific SDK to the shatteredruby site."
  #task :upload do
    # todo
  #end
  
  desc "Clear out the intermediate built vendor files."
>>>>>>> e167682624e4354922dd00960c7dc7c967a05d85:tasks/vendor.rake
  task :clean do
    FileUtils.mkdir_p work
    FileUtils.rm_r work
  end
  
  desc "Download and build the Bullet SDK."  
  task :update => [:clean, :download, :build]
  task :default => :update  
end
