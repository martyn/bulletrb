require 'active_support'

class String
  def capitalize
    return self[0].chr.upcase+self[1..-1]
  end
end

def generate_cpp(file)
  classes = []
  current_class = nil
  File.open(file).each_with_index do |line, line_number|
    line, void = line.split("#")
    #skip empty lines
    next if line.strip.length == 0
    args = line.split " "
    op = args.delete_at 0
    #create new classes
    if op == "class"
      classes << current_class unless current_class.nil?
      class_name, inherits, sc = args
      current_class = GenClass.new class_name
      unless inherits.nil?
        current_class.superclass = sc
      end
    elsif op == "enum"
      classes << current_class unless current_class.nil?
      current_class = GenEnum.new args
    elsif op == "def"
      method = current_class.create_method(args.join(" "))
      current_class.methods << method
    else
      raise "error on line #{line_number}, undefined op '#{op}'"
    end
  end
  classes << current_class unless current_class.nil?
  generate_output(sort_by_hierachy(nest_classes(classes)))
end

#move nested classes under their parents
def nest_classes(classes)
  classes  
#  parents = classes.dup.delete_if do |c|
#    !c.parent.nil?
#  end
#  
#  puts "parents = #{parents}"

#  children = classes.dup.delete_if do |c|
#    c.parent.nil?
#  end
#  
#  puts "children = #{children}"
#  
#  children.each do |child|
#    parents.each do |parent|
#      if child.parent == parent.name
#        parent.children << child
#        break
#      end
#    end    
#  end
#  
#  return parents
end

#Brings the subclasses to the top
def sort_by_hierachy(classes)
  classes.each_with_index do |val, i|
    next if classes[i].superclass == nil
    (i...classes.length).each do |j|
      if classes[i].superclass == classes[j].name
        classes[i],classes[j] = classes[j],classes[i] 
#        puts classes[i].name, classes[j].name
      end
    end
  end
  return classes
end

def generate_output(classes)
cpp = <<-EOL

#include "helper.h"

using namespace Rice;
  
extern "C"
  void Init_bullet() {

  #{classes.collect do |c| c.to_cpp + ";  \n";end }
    }
 EOL
  file = File.open(File.dirname(__FILE__)+"/../lib/cpp/bullet.cpp", "w")
  file.puts cpp
  file.close
end

class GenEnumVal
  attr_accessor :name
  def initialize(str)
    @name = str
  end
  
end

class GenEnum
  attr_accessor :name, :methods, :parent
  def initialize(args)
    @methods = []
    @name = args[0]
    @parent
  end

  def superclass
    nil
  end
  
  def create_method(*args)
    return GenEnumVal.new(*args)
  end
  
  def to_cpp
    retv = "\n  Rice::Enum<bt#{@name}> rb_c#{name} ="
    retv += "\n    define_enum<bt#{name}>(\"#{name}\")"
    @methods.each do |enum|
      retv += "\n    .define_value(\"#{enum.name}\", BT_#{enum.name})"
    end
    return retv
  end
end

class GenMethod
  attr_writer :name
  attr_accessor :types
  def initialize(str)
    @singleton=false
    
    @types = str.split(/[\( )]/)
    @name = @types.delete_at 0
    @types = @types.join(" ").split(/[, ]/)
    @types.collect! { |type| type.strip }
    @types.delete ""
    
    if @types.include? "=>"
      @types.delete "=>"
      @cname = @types[-1]
    end
    
    #handle static methods
    if /^self./ =~ @name
      @singleton = true
      @name = @name[5..-1]
    end
  end
  
  def constructor?
    @name == "initialize"
  end
  
  def name
    @name.underscore
  end
  
  def cname
    @cname || @name
  end
  
  def custom?
    !@cname.nil?
  end

  def singleton?
    @singleton
  end
 
  def to_s
    name
  end 
end

class GenClass
  attr_accessor :superclass, :methods, :parent, :children
  attr_reader :name
  def initialize(name)
    @methods = []
    @superclass = nil
    @name = name
    @parent = nil
    @children = []
    
    #handle nested classes
    args = name.split("::")
    if args.length > 1
      @parent = args[-2]
      @name = args[-1]
    end
  end
  
  def to_s
    "GenClass #{@name} #{@methods.join(",")}\n"
  end
  
  def cname
    if @parent == nil
      return "bt#{name}"
    else
      return "bt#{parent}::bt#{name}"
    end
  end
  
  def to_cpp
    retv = "\n  Data_Type<#{cname}> rb_c#{name} ="
    retv += "\n    define_module(\"Bullet\")"
    retv += to_cpp_class
    #@children.each do |child|
    #  retv += child.to_cpp_class
    #end
    retv
  end
  
  def to_cpp_class
    retv = ""
    if(superclass.nil?)
      retv += "\n    .define_class<#{cname}>(\"#{name}\")"
    else
      retv += "\n    .define_class<#{cname}, bt#{@superclass}>(\"#{name}\")"
    end  
    @methods.each do |method|
      if method.constructor?
        retv += "\n    .define_constructor(Constructor<#{cname}>())" if method.types.empty?
        retv += "\n    .define_constructor(Constructor<#{cname}, #{method.types.join(", ")}>())" unless method.types.empty?    
      else
        if method.singleton?
          retv += "\n    .define_singleton_method(\"#{method.name}\", &#{name}_#{method.cname.capitalize})"
        elsif method.custom?
          retv += "\n    .define_method(\"#{method.name}\", &#{method.cname})"
        else        
          retv += "\n    .define_method(\"#{method.name}\", &#{cname}::#{method.cname})"
        end
      end
    end
    retv
  end
  
  def create_method(*args)
    return GenMethod.new(*args)
  end
  
end

