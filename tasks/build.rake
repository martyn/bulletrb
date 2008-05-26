require File.dirname(__FILE__)+'/rbpp_bindings'
  
desc "compile and link the bulletrb c++ bindings"
namespace :build do
  task :build do
    sh "ruby lib/cpp/extconf.rb"
    sh "make"
    if(Platform.linux?)
      mv "bullet.so", "lib/cpp"
    elsif(Platform.mac?)
      mv "bullet.bundle", "lib/cpp"
    else
      #Windows
    end
    puts "mv bullet lib/cpp"
  end
  
  desc "Update the rb++ bindings"
  task :generate => [:clean, :generate_namespace, :generate_rbpp]
  
  task :clean do
    target = File.dirname(__FILE__)+"/../lib/cpp/generated"
    FileUtils.rm_r target if File.directory?(target) 
  end
  
  task :generate_rbpp do
    generate_rbpp
  end
  
  task :generate_namespace do
    generate_headers
  end
  
  task :rebuild => [:generate, :build]
  task :default => :build
end

