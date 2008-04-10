module Bullet
  class CollisionShape
    def wireframe_mesh(scene_manager, mesh_name)
      a, b = Vector3.new(0,0,0), Vector3.new(0,0,0)
      manual = scene_manager.create_manual_object(mesh_name)
      manual.begin("BaseWhiteNoLighting", Ogre::RenderOperation::OT_LINE_LIST)

      get_num_edges.times do |i|
        get_edge(i, a, b)
        [a,b].each do |pt|
          manual.position(pt.x, pt.y, pt.z)
        end
      end
      manual.end
      
      Ogre::MeshInstance.new(scene_manager.root_scene_node, scene_manager, mesh_name, :entity => manual)
    end
  end
  
  class BoxShape
    def manual_object(manual, pts, verts)      
      texture_coords = [[0,0], [0,1], [1,0],[1,1]]
      
      manual.begin("Box", Ogre::RenderOperation::OT_TRIANGLE_STRIP)
      verts.each_with_index do |i, index|
        manual.position(pts[i].x, pts[i].y, pts[i].z)
        manual.texture_coord(texture_coords[index][0],texture_coords[index][1])
      end
      manual.end
         
    end
    
    def debug_mesh(scene_manager, mesh_name)
      pts = []
      manual = scene_manager.create_manual_object(mesh_name)

      get_num_vertices.times do |i|
        pt = Vector3.new(0,0,0)
        get_vertex(i, pt)
        pts << pt
        pts = pts.sort_by {|pt| [pt.x, pt.y, pt.z] }
      end
      
      manual_object manual, pts, [0,1,2,3]
      manual_object manual, pts, [6,7,4,5] 
              
      manual_object manual, pts, [0,2,4,6]
      manual_object manual, pts, [5,7,1,3]
      
      manual_object manual, pts, [4,5,0,1]
      manual_object manual, pts, [2,3,6,7]
   
            
      Ogre::MeshInstance.new(scene_manager.root_scene_node, scene_manager, mesh_name, :entity => manual)      
    end
  end
end
