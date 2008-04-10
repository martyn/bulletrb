module Bullet
  class RigidBody
    def show_debug(scene_manager, mesh_name, shape, wireframe=false) # TODO: remove shape dependency - RigidBody should just know.
      @debug_mesh = shape.debug_mesh(scene_manager, mesh_name) unless wireframe
      @debug_mesh = shape.wireframe_mesh(scene_manager, mesh_name) if wireframe
      update_debug_mesh
    end
    
    def hide_debug
      return unless @debug_mesh
      @debug_mesh.unload
      @debug_mesh = nil
    end
    
    def update_debug_mesh
      return unless @debug_mesh
      @debug_mesh.position = get_center_of_mass_position.to_ogre
      @debug_mesh.orientation = get_orientation.to_ogre
    end
  end
end