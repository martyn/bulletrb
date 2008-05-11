require 'rubygems'
require 'pmsrb'

include PMS

desc "Update the vendor headers/lib for bullet"
namespace :vendor do
  work = File.dirname(__FILE__)+"/../tmp"
  bullet_extensions="bullet-extensions-#{Bulletrb::VERSION::STRING}-#{Platform.short_name}.#{Platform.preferred_archive}"
  
  desc "Download the bullet SDK from google code."
  task :download do
    PMS::vendor do
      working_directory work
      if Platform.windows?
        download "http://bullet.googlecode.com/files/bullet-#{Bulletrb::VERSION::VENDOR}.zip"
      else
        download "http://bullet.googlecode.com/files/bullet-#{Bulletrb::VERSION::VENDOR}.tgz"
      end
      extract
    end
  end
  
  desc "Build the downloaded bullet SDK."
  task :build do
    PMS::vendor do
      working_directory work
      cd "bullet-#{Bulletrb::VERSION::VENDOR}"
      unless(Platform.mac?)
        build "./configure", "jam"
      else
        build "cmake . -G Xcode", "xcodebuild"
      end
    end
  end
  
  #desc "Upload the built, platform-specific SDK to the shatteredruby site."
  #task :upload do
    # todo
  #end
  
  desc "Clear out the intermediate built vendor files."
  task :clean do
    FileUtils.mkdir_p work
    FileUtils.rm_r work
    FileUtils.mkdir_p work
  end
  
  desc "Download and build the Bullet SDK."  
  task :update =>[:clean, :download, :build]
  
  desc "Upload the platform specific bulletrb binaries."
  task :upload_extensions => [:clean] do
    # In our extension, we grab the binaries from our website.
    vendor do
      working_directory File.join(File.dirname(__FILE__),'..','lib','cpp')
      archive "*.bundle", bullet_extensions
      upload bullet_extensions do
        host "ftp.shatteredruby.com"
        credentials ".shattered_pms"
        target_directory "web/shatteredruby.com/public/vendor"
      end
    end
  end
  
  desc "Download the platform specific bulletrb binaries."
  task :download_extensions do
    # In our extension, we grab the binaries from our website.
    vendor do
      working_directory File.join(File.dirname(__FILE__),'..','lib','cpp')
      download "http://shatteredruby.com/vendor/#{bullet_extensions}"
      extract
      rm bullet_extensions
    end
    
  end
  task :default => :update  
end
