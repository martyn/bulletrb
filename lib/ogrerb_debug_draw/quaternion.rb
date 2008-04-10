module Bullet
  class Quaternion
    def to_ogre
      return Ogre::Quaternion.new(w,x,y,z)
    end
  end
end