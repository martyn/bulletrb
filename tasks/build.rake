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
  task :generate => [:generate_namespace, :generate_rbpp]
  
  task :clean_rbpp do
    FileUtils.rm_r File.dirname(__FILE__)+"/generated"
  end
  
  task :generate_rbpp do
    generate_rbpp
  end
  
  task :generate_namespace do
    generate_headers
  end
  
  task :rebuild => [:clean_rbpp, :generate, :build]
  task :default => :build
end

