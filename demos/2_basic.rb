require File.dirname(__FILE__)+"/demo_application"
require File.join(File.dirname(__FILE__),"..","lib","ogrerb_debug_draw")

include Bullet

#///create 125 (5x5x5) dynamic object
ARRAY_SIZE = [5,5,5]

#//maximum number of objects (and allow user to shoot additional boxes)
MAX_PROXIES = 1024 + ARRAY_SIZE[0]+ARRAY_SIZE[1]+ARRAY_SIZE[2]

START_POS =[-5, -5, -3]

##include "BasicDemo.h"
##include "GlutStuff.h"
#///btBulletDynamicsCommon.h is the main Bullet include file, contains most common include files.
##include "btBulletDynamicsCommon.h"
##include <stdio.h> //printf debugging
#using motionstate is recommended, it provides interpusing motionstate is recommended, it provides interpolation capabilities, and only synchronizes 'active' objectsolation capabilities, and only synchronizes 'active' objects

class BasicDemo < DemoApplication
  title "Basic Box Demo"
  timer :every => :frame, :action => :update_debug_objects
  def initialize
    super
    @collision_objects = []
  end
  
  def update_debug_objects
    GC.start
    @dynamicsWorld.step_simulation(time_elapsed, 10, 1.0/60.0)
    @collision_objects.each do |obj|
      obj.update_debug_mesh
    end
  end
  
  def clientMoveAndDisplay
    ## Display code
  end
  def initPhysics
#	setCameraDistance(btScalar(50.));

#	///collision configuration contains default setup for memory, collision setup
    @collisionConfiguration = DefaultCollisionConfiguration.new(nil,nil,nil)

#	///use the default collision dispatcher. For parallel processing you can use a diffent dispatcher (see Extras/BulletMultiThreaded)
    @dispatcher = CollisionDispatcher.new(@collisionConfiguration)

#	///the maximum size of the collision world. Make sure objects stay within these boundaries
#	///Don't make the world AABB size too large, it will harm simulation quality and performance
    worldAabbMin = Vector3.new(-10000,-10000,-10000)
    worldAabbMax = Vector3.new(10000,10000,10000)
    @overlappingPairCache = AxisSweep3.new(worldAabbMin,worldAabbMax,MAX_PROXIES,nil)

#	///the default constraint solver. For parallel processing you can use a different solver (see Extras/BulletMultiThreaded)
    @solver = SequentialImpulseConstraintSolver.new
    
    @dynamicsWorld = DiscreteDynamicsWorld.new(@dispatcher,@overlappingPairCache,@solver,@collisionConfiguration)
    @dynamicsWorld.set_gravity(Vector3.new(0,-10,0))

#	///create a few basic rigid bodies
    groundShape = StaticPlaneShape.new(Vector3.new(0,1,0),50)

    groundTransform = Transform.get_identity
  	groundTransform.set_origin(Vector3.new(0,-56,0))

#	//We can also use DemoApplication::localCreateRigidBody, but for clarity it is provided here:

		localInertia = Vector3.new(0,0,0)
    @motion_states = []
    
#		//using motionstate is recommended, it provides interpolation capabilities, and only synchronizes 'active' objects
		myMotionState = DefaultMotionState.new(groundTransform, Transform.get_identity)
  	body = RigidBody.new(mass=0,myMotionState,groundShape,localInertia)

		@collision_objects << body
		@motion_states << myMotionState

#		//add the body to the dynamics world
		@dynamicsWorld.add_rigid_body(body)


#	{
#		//create a few dynamic rigidbodies
#		// Re-using the same collision is better for memory usage and performance
		@colShape = BoxShape.new(Vector3.new(1,1,1))

#		/// Create Dynamic Objects
    startTransform = Transform.get_identity
    mass = 10.0
    
		@colShape.calculate_local_inertia(mass,localInertia)
    
    start_x = START_POS[0] - ARRAY_SIZE[0]/2
		start_y = START_POS[1]
		start_z = START_POS[2] - ARRAY_SIZE[2]

    0.upto(ARRAY_SIZE[0]) do |k|
      0.upto(ARRAY_SIZE[1]) do |i|
        0.upto(ARRAY_SIZE[2]) do |j|
  			  startTransform.set_origin(Vector3.new((2.0)*i + start_x, 2.0*k + start_y, 2.0*j + start_z))
          
          #	using motionstate is recommended, it provides interpolation capabilities, and only synchronizes 'active' objects
  	  		myMotionState = DefaultMotionState.new(startTransform, Transform.get_identity)
  				body = RigidBody.new(mass,myMotionState,@colShape,localInertia)
  				body.show_debug(scene_manager, "test[#{k},#{i},#{j}]", @colShape)
      		@collision_objects << body
      		@motion_states << myMotionState
      		  				
  				@dynamicsWorld.add_rigid_body(body)
        end
      end
    end
    
    #Draw the ground   
    p = Ogre::Plane.new
    p.normal = Ogre::Vector3.UNIT_Y
    p.d = 6

    Ogre::MeshManager.instance.create_plane("FloorPlane", 
      Ogre::ResourceGroupManager.DEFAULT_RESOURCE_GROUP_NAME, p, 700, 700, 20, 20, true,
      1, 5, 5, Ogre::Vector3.UNIT_Z)
      
    entity = scene_manager.create_entity("floor", "FloorPlane")
    mat_name = create(:material, :basic, :texture => "ground.jpg").name
    
    entity.set_material_name(mat_name)

    scene_manager.root_scene_node.attach_object(entity)
#    #put a sky in
    sky = create :material, :basic, :texture => "sky.png"
    scene_manager.set_sky_dome(true, sky.name, 5, 8)

#	clientResetScene();
#	  @dynamicsWorld.set_debug(true)
  end

  def exitPhysics()
    log.info("Deleting #{@collision_objects.length} objects.")
    @collision_objects.each do |obj|
      @dynamicsWorld.remove_collision_object obj
    end
  end
end

demo = BasicDemo.instance
demo.myinit
demo.initPhysics
demo.play
demo.exitPhysics

