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
    wrap_into( m, [node.classes, node.structs].flatten)
  end    

  clean_up_custom(node)
  rename_functions(node)
  
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

def rename_functions(node)
  node.classes("btTransform").methods("getOrigin")[0].wrap_as("get_origin")
end

def wrap_into(mod, classes)
  return if classes.empty?
  classes.each { |c| c.ignore if c.name.nil? }
  classes.delete_if { |c| c.name.nil? }
  classes.sort_by {|c| c.name}.each do |cls|
    clean_up(cls, mod)
    clean_up_methods(cls)
    clean_up_constructors(cls)
    wrap_into(cls, [cls.classes, cls.structs].flatten)
  end
end

def clean_up_methods(cls) 
  cls.methods.sort_by { |method| method.name}.each do |method|    
    if blacklist_method(method)
      method.ignore
      puts "  ignoring #{method.name} - blacklisted"
    end
  end
end

def blacklist_method(method)
  return true if blacklist_name method.attributes["demangled"]
  
  if  (/void *\*/ === method.return_type.to_s) || 
      (/void *\*/ === method.attributes["demangled"] ||
      (/Callback/ === method.return_type.to_s) || 
      (/Callback/ === method.attributes["demangled"]) ||
      (/Func/ === method.return_type.to_s) || 
      (/Func/ === method.attributes["demangled"])
      )
    puts "  ignoring #{method.name} - void*"
    return true 
  end
  return false
end

def clean_up_constructors(cls)
  cls.constructors.each do |constructor|
    if blacklist_name(constructor.attributes["demangled"])
      puts "ignoring #{cls.name} constructor for using blacklisted type"
      constructor.ignore
    end  
  end
  
  abstract_filter(cls)
end

def clean_up_custom(node)
  # abstract classes not caught
  %w(btEmptyShape btSimpleDynamicsWorld btTriangleMeshShape).each do |cname|
    puts "ignoring #{cname} - custom abstract"
    mark_abstract(node.classes(cname))
  end
  
  ignore node.classes("btOptimizedBvh").methods("getLeafNodeArray")
  ignore node.classes("btOptimizedBvh").methods("getSubtreeInfoArray")
  ignore node.classes("btOptimizedBvh").methods("getQuantizedNodeArray")
  ignore node.classes("btTransform").constructors[1..-1]
  #ignore node.structs("btVehicleRaycaster").constructors
  #ignore node.structs("btStorageResult").constructors
  ignore node.structs("btDiscreteCollisionDetectorInterface").structs("Result").constructors
  
  ignore node.structs("btCollisionResult")
  ignore node.structs("btVehicleTuning")
  ignore node.structs("btConvexCastResult")
  ignore node.structs("btCollisionAlgorithmConstructionInfo")
  ignore node.classes("btMultiSapBroadphase").structs("btBridgeProxy")
  
  ignore node.classes("btIDebugDraw")
  
  origins = node.classes("btTransform").methods("getOrigin")
  origins[0].ignore
  origins[1].wrap_as("get_origin").calls("Transform_GetOrigin")
  node.classes("btTransform").methods("getIdentity").calls("Transform_GetIdentity")
 
  %w(btNullPairCache btSortedOverlappingPairCache btHashedOverlappingPairCache btOverlappingPairCache).each do |c_name|
    node.classes(c_name).methods.each do |method|
      ignore method if /Pair/ === method.name
    end
  end
end

# This method cleans up structs
def clean_up(struct, mod)
  if !(/^bt/ === struct.name)
    puts "ignoring #{struct.name}"
    struct.ignore
  elsif blacklist_name(struct.name)
    puts "ignoring #{struct.name} - blacklisted"
    struct.ignore
  else
    puts "exporting #{struct.name[2..-1]}"
    mod.includes struct.wrap_as(struct.name[2..-1])
  end
end

# custom ignore an element
def ignore(node)
  [node].flatten.each do |n|
    puts "ignoring #{n.qualified_name} - custom ignore"
    n.ignore
  end
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
  return true if /DiscreteCollisionDetectorInterface/ === name
  return true if /Result$/ === name
  return true if /btBridgeProxy/ === name
  return true if /16u/ === name
  return true if /AlignedObjectArray/ === name
  return true if /processAllOverlappingPairs/ === name
  return true if /void *\*/ === name
  ##

  return true if /Callback$/ === name
  return true if /Solve2LinearConstraint$/ === name # Not sure what this class does
#  return true if name.include? "<" # ignore templates
#  return true if name.include? "_" # ignore templates
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
  header.puts "  #include \"#{File.join($bullet_home, "LinearMath", "btStackAlloc.h")}\""
  header.puts "  #include \"#{File.join($bullet_home, "BulletCollision", "NarrowPhaseCollision", "btVoronoiSimplexSolver.h")}\""
  header.puts "  #include \"#{File.join($bullet_home, "BulletCollision", "CollisionDispatch", "btSimulationIslandManager.h")}\""
  header.puts "  #include \"#{File.join($bullet_home, "BulletCollision", "NarrowPhaseCollision", "btGjkEpaPenetrationDepthSolver.h")}\""
  #header.puts "}"
  
  header.puts "#endif"
  header.close
end
