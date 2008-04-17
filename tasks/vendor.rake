require 'rubygems'
require 'pmsrb'

include PMS

desc "Update the vendor headers/lib for bullet"
namespace :vendor do
#  task :update do
#    unless(ENV["BULLET_HOME"])
#      puts "Please define BULLET_HOME to point to the new INSTALLED bullet version (/usr/local/ is common on linux).  Thanks, Bye."
#    else
#      rm_r File.join(File.dirname(__FILE__), "..", "vendor", "bullet", "include", Platform.short_name)
#      mkdir_p File.join(File.dirname(__FILE__), "..", "vendor", "bullet", "lib", Platform.short_name)
#      mkdir_p File.join(File.dirname(__FILE__), "..", "vendor", "bullet", "include", Platform.short_name)
#      Dir[ENV["BULLET_HOME"]+"/include/bullet/**/*.h"].each do |file|   
#        path = file.split("include/bullet/")[1].split("/")[0...-1].join("/")
#        destination_dir = File.join(File.dirname(__FILE__), "..", "vendor", "bullet", "include", path)
#        mkdir_p destination_dir
#        cp file, destination_dir
#        puts "'#{file}' => '#{destination_dir}'"
#      end
#      Dir[ENV["BULLET_HOME"]+"/lib/libbullet*"].each do |file|   
#        path = file.split("lib/")[-1].split("/")[0...-1].join("/")
#        destination_dir = File.join(File.dirname(__FILE__), "..", "vendor", "bullet", "lib", path)
#        mkdir_p destination_dir
#        cp file, destination_dir
#        puts "'#{file}' => '#{destination_dir}'"
#      end
#    end
#  end
#  task :default => :update
#  
  work = File.dirname(__FILE__)+"/../tmp"
  task :download do
    download work
  end
  
  task :build do
    build(work)
  end
  
  task :clean do
    clean(work)
  end
  
  task :update do
    clean work
    download work
    build work
  end
  
  task :default => :update
  
  def download(work)
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
  
  def clean(work)
    FileUtils.mkdir_p work
    FileUtils.rm_r work
  end
  
  def build(work)
    PMS::vendor do
      working_directory work
      cd "bullet-2.68"
      puts build "./configure", "jam"
    end
  end
end
