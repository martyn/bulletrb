class Crosshair < Shattered::Actor
  def initialize
    # Create a manual object for 2D
    manual = scene_manager.create_manual_object("manual")

    # Use identity view/projection matrices
    manual.set_use_identity_projection(true)
    manual.set_use_identity_view(true)

    manual.begin("BaseWhiteNoLighting", Ogre::RenderOperation::OT_LINE_LIST)

    manual.position(-0.01, 0.0, 0.0)
    manual.position( 0.01, 0.0, 0.0)
    manual.position( 0.0,  -0.01, 0.0)
    manual.position( 0.0,  0.01, 0.0)

    manual.index(0)
    manual.index(1)
    manual.index(2)
    manual.index(3)
    manual.index(0)

    manual.end

    # Use infinite AAB to always stay visible
    aabInf = Ogre::AxisAlignedBox.new
    aabInf.set_infinite
    manual.set_bounding_box(aabInf)

    # Render just before overlays
    manual.set_render_queue_group(Ogre::RENDER_QUEUE_OVERLAY - 1)

    @crosshair = Ogre::MeshInstance.new(scene_manager.root_scene_node, scene_manager, "Crosshair", :entity => manual)      
  end
end
