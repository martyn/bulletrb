Dir["#{File.dirname(__FILE__)}/*.rb"].each do |file|
  require file
end

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

  desc "Generates rice bindings from rbi files"
  task :generate_rice do
    generate_cpp(File.dirname(__FILE__)+"/../lib/cpp/bullet.rbi")
  end
  
  desc "Generates rbi files cpp headers"
  task :generate_rbi do
    out = File.open("header_to_rbi.log", "w")
    Dir[File.dirname(__FILE__)+"/../vendor/bullet/include/**/*.h"].each do |header|
      out.puts
      out.puts
      out.puts header
      out.puts
      out.puts
      out.puts CppParser::Parser.new(header).to_rbi
      puts header
    end
    puts "All files parsed.   See 'header_to_rbi.log' for details."
  end
  
  desc "Regenerate and rebuild"
  task :rebuild => [:generate_rice, :build]
  
  task :default => :rebuild
end

