module Bullet
  class CollisionObject
    def show_debug
      get_collision_shape.show_debug
    end
    
    def hide_debug
      get_collision_shape.hide_debug
    end
  end
end
