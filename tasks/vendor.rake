desc "Update the vendor headers/lib for bullet"
namespace :vendor do
  task :update do
    unless(ENV["BULLET_HOME"])
      puts "Please define BULLET_HOME to point to the new INSTALLED bullet version (/usr/local/ is common on linux).  Thanks, Bye."
    else
      rm_r File.join(File.dirname(__FILE__), "..", "vendor", "bullet", "include")
      mkdir_p File.join(File.dirname(__FILE__), "..", "vendor", "bullet", "lib")
      mkdir_p File.join(File.dirname(__FILE__), "..", "vendor", "bullet", "include")
      Dir[ENV["BULLET_HOME"]+"/include/bullet/**/*.h"].each do |file|   
        path = file.split("include/bullet/")[1].split("/")[0...-1].join("/")
        destination_dir = File.join(File.dirname(__FILE__), "..", "vendor", "bullet", "include", path)
        mkdir_p destination_dir
        cp file, destination_dir
        puts "'#{file}' => '#{destination_dir}'"
      end
      Dir[ENV["BULLET_HOME"]+"/lib/libbullet*"].each do |file|   
        path = file.split("lib/")[-1].split("/")[0...-1].join("/")
        destination_dir = File.join(File.dirname(__FILE__), "..", "vendor", "bullet", "lib", path)
        mkdir_p destination_dir
        cp file, destination_dir
        puts "'#{file}' => '#{destination_dir}'"
      end
    end
  end
  task :default => :update
end
