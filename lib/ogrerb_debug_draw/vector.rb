module Bullet
  class Vector3
    def to_ogre
      Ogre::Vector3.new(x,y,z)
    end
    def to_s
      "<Bullet::Vector3 #{x}, #{y}, #{z}>"
    end
  end
end

module Ogre
  class Vector3
    def to_bullet
      Bullet::Vector3.new(x,y,z)
    end
  end
end