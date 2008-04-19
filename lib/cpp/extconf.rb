require 'rubygems'

require 'mkmf-rice'
require 'pmsrb'

require File.expand_path(File.dirname(__FILE__)+"/../bulletrb/version")

# Add the arguments to the cpp compiler flags.
def append_cpp_flags(flags)
  flags = [flags] unless flags.is_a?(Array)
  with_cppflags("#{$CPPFLAGS} #{flags.join(' ')}") { true }
end

# Add the arguments to the linker flags.
def append_ld_flags(flags)
  flags = [flags] unless flags.is_a?(Array)
  with_ldflags("#{$LDFLAGS} #{flags.join(' ')}") { true }
end

# Add arguments to the c compiler flags.
def append_c_flags(flags)
  flags = [flags] unless flags.is_a?(Array)
  with_cflags("#{$CFLAGS} #{flags.join(' ')}") { true }
end

# Used like append_ld_flags(libpath("ogre"))
def libpath(project)
  " -L\"#{File.expand_path(File.dirname(__FILE__)+"/../../tmp/#{project}/lib/#{Platform.short_name}")}\""
end

folder = "bullet-#{Bulletrb::VERSION::VENDOR}"

append_cpp_flags("-I\"#{File.expand_path(File.dirname(__FILE__))}/../../tmp/#{folder}/src\"")
append_ld_flags(libpath folder)

if(Platform.linux?)
  append_ld_flags("-lbulletcollision -lbulletdynamics -lbulletmath")
elsif(Platform.mac?)
  # In order to link the shared library into our bundle with GCC 4.x on OSX, we have to work around a bug:
  #   GCC redefines symbols - which the -fno-common prohibits.  In order to keep the -fno-common, we
  #   remove the flat_namespace (we now have two namespaces, which fixes the GCC clash).  Also, we now lookup
  #   symbols in both the namespaces (dynamic_lookup).
  $LDSHARED_CXX.gsub!("suppress", "dynamic_lookup")
  $LDSHARED_CXX.gsub!("-flat_namespace", "")

  append_ld_flags("-lLibBulletCollision -lLibBulletDynamics -lLibLinearMath -all_load")
else
  # TODO: windows
end
create_makefile 'bullet'
