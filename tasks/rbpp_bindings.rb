require 'rubygems'
require 'rbplusplus'
require File.dirname(__FILE__)+"/global_namespace"

$root = File.expand_path(File.join(File.dirname(__FILE__), ".."))
require File.join($root, 'lib', 'bulletrb', 'version')
  
$bullet_home = File.join($root, "tmp", "bullet-#{Bulletrb::VERSION::VENDOR}", "src")
$cpp_home = File.join($root, "lib", "cpp")


# This method generates the extension into lib/cpp/generated and compiles it
def generate_rbpp
  e = RbPlusPlus::Extension.new "bullet"
  e.working_dir=File.join($cpp_home, "generated")
  
  lib_path = ""
  Platform.linux do
    lib_path << File.expand_path("#{$bullet_home}/../out/linuxx86/optimize/libs")
  end
  e.sources("#{$cpp_home}/bullet_namespace.h", 
              :include_paths  => [$bullet_home], 
              :includes       => File.join($cpp_home, "helper.h"),
              :library_paths  => lib_path+" #{lib_path}/libbulletcollision.a #{lib_path}/libbulletdynamics.a #{lib_path}/libbulletmath.a"
            )
  
  node = e.global_namespace
  node.functions.each do |f| 
    f.ignore
  end
  
  e.module "Bullet" do |m|
  
    node.classes.sort_by {|c| c.name}.each do |cls|
      if blacklist cls
        puts "ignoring #{cls.name}"
        cls.ignore
      elsif /^bt/ === cls.name
        puts "exporting #{cls.name}"
        cls.wrap_as cls.name.gsub(/^bt/, "")
        m.includes cls
      else
        puts "ignoring #{cls.name} as external class"
        cls.ignore
      end
      
      methods_hash = {}
      cls.methods.sort_by { |method| method.name}.each do |method|
        if methods_hash[method.name]
          methods_hash[method.name].ignore
          method.ignore
          puts "  ignoring #{method.name} due to overloading"
        end
        methods_hash[method.name] = method
        
        if  /UserPointer$/ === method.name  ||
            /^free/ === method.name         ||
            /^allocate/ === method.name     ||
            /Callback$/ === method.name     ||
            /deSerializeInPlace$/ === method.name ||
            /[gsGS]et.*Func$/ === method.name
          method.ignore 
          puts "  ignoring #{method.name} for using void *"
        end
        
        if blacklist_name method.attributes["demangled"]
          method.ignore
          puts "  ignoring #{method.name} - blacklisted"
        end
      end
      
      cls.constructors.each do |constructor|
        if blacklist_name(constructor.attributes["demangled"])
          puts "ignoring #{cls.name} constructor for using blacklisted type"
          constructor.ignore
        end  
      end
      
      abstract_filter(cls)
    end
    
    # abstract classes not caught
    %w(btEmptyShape btSimpleDynamicsWorld btTriangleMeshShape).each do |cname|
      puts "ignoring #{cname} - custom abstract"
      mark_abstract(node.classes(cname))
    end
    
    ignore node.classes("btOptimizedBvh").methods("getLeafNodeArray")
    ignore node.classes("btOptimizedBvh").methods("getSubtreeInfoArray")
    ignore node.classes("btOptimizedBvh").methods("getQuantizedNodeArray")
    ignore node.classes("btDefaultVehicleRaycaster").methods("castRay")
  
    
    %w(btNullPairCache btSortedOverlappingPairCache btHashedOverlappingPairCache btOverlappingPairCache).each do |c_name|
      node.classes(c_name).methods.each do |method|
        ignore method if /Pair/ === method.name
      end
    end
    
    node.structs.each do |struct|
      clean_up_struct struct
    end
  end
  
  puts "creating bindings..."
  e.build
  e.write
  FileUtils.cp($cpp_home+"/helper.cpp", e.working_dir)
  
  puts "compiling... this may take a while"
  e.compile
  
  FileUtils.rm(e.working_dir+"/helper.cpp")
  
  if !File.exists?(e.working_dir+"/bullet.so")
    puts "Error compiling, check the logs"
  else
    FileUtils.cp(e.working_dir+"/bullet.so", $cpp_home)
  
    puts "Testing require"
    require $cpp_home+'/bullet'
  end
  
end


# This method cleans up structs
def clean_up_struct(struct)
  if !(/^bt/ === struct.name) || blacklist_name(struct.name)
    puts "ignoring #{struct.name} as struct"
    struct.ignore
  else
    puts "exporting struct #{struct.name}"
  end
end

# custom ignore an element
def ignore(node)
  puts "ignoring #{node.name} - custom ignore"
  node.ignore
end

# ignore abstract constructors
def mark_abstract(cls)
  cls.constructors.each { |c| c.ignore }
end

# matches abstract classes
# note, this does not always work
def abstract_filter(cls)
  cls.methods.each do |method|
  
    if method.attributes["pure_virtual"] == "1"
      puts "ignoring #{cls.name} constructors as abstract (#{cls.name}##{method.name})"
      mark_abstract cls
    end     
        
  end
end

# returns true if the cls is blacklisted
def blacklist(cls)
  blacklist_name cls.qualified_name
end

# returns true if the string name contains blacklisted elements
def blacklist_name(name)
  #Cannot find symbol?
  
  return true if /btRaycastVehicle/ === name
  return true if /createAabbTreeFromChildren/ === name
  
  ##

  return true if /Callback$/ === name
  return true if /Solve2LinearConstraint$/ === name # Not sure what this class does
  return true if name.include? "<" # ignore templates
  return true if name.include? "_" # ignore templates
  return false
end

# generates the headers
# note, this used to attempt to create a Bullet namespace
# but when linking symbols get confused since the library
# is compiled into the global namespace. 
def generate_headers
  header = File.open(File.join($cpp_home, "bullet_namespace.h"), 'w')
  header.puts "#ifndef __BULLET_NAMESPACE_H__"
  header.puts "#define __BULLET_NAMESPACE_H__"
  header.puts "#include <iostream>" 
  #header.puts "namespace Bullet {"
  
  Dir.glob(File.join($bullet_home, "bt*.h")).each do |file|
    header.puts "  #include \"#{file}\""
  end
  header.puts "  #include \"#{File.join($bullet_home, "LinearMath", "btPoolAllocator.h")}\""
  #header.puts "}"
  
  header.puts "#endif"
  header.close
end
