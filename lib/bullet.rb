$:.unshift File.dirname(__FILE__)

require File.expand_path(File.dirname(__FILE__)+"/cpp/bullet")
require File.expand_path(File.dirname(__FILE__)+"/bulletrb/version")

module Bullet
  class Vector3
    def to_s
      "Vector3(x=#{x} y=#{y} z=#{z})"
    end
    
    def ==(other)
      return false unless other.is_a? Vector3
      return x==other.x && y==other.y && z==other.z
    end
  end  
end
