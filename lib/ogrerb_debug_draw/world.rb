module Bullet
  class DiscreteDynamicsWorld
#    alias :bullet_add_rigid_body :add_rigid_body
#    def add_rigid_body(x)
      #@rigid_bodies ||= []
      #@rigid_bodies << x
 #     bullet_add_rigid_body x
#    end
    
    def show_debug
      @rigid_bodies.each do |body| 
        body.show_debug 
      end
    end
    
    def hide_debug
      @rigid_bodies.each do |body| 
        body.hide_debug 
      end
    end
    
    #alias_method :bullet_remove_collision_object, :remove_collision_object 
#    def remove_collision_object(x)
#      @rigid_bodies.delete x
#      bullet_remove_collision_object x
#    end
  end
end
