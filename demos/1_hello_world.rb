require File.join(File.dirname(__FILE__),"..","lib","bullet")
include Bullet    

collision_objects = []
motion_states = []

#collision configuration contains default setup for memory, collision setup. Advanced users can create their own configuration.
collisionConfiguration = DefaultCollisionConfiguration.new(nil,nil,nil)

#use the default collision dispatcher. For parallel processing you can use a diffent dispatcher (see Extras/BulletMultiThreaded)
dispatcher = CollisionDispatcher.new(collisionConfiguration)

#the maximum size of the collision world. Make sure objects stay within these boundaries
#Don't make the world AABB size too large, it will harm simulation quality and performance
worldAabbMin = Vector3.new(-10000,-10000,-10000)
worldAabbMax = Vector3.new(10000,10000,10000)
maxProxies = 1024
overlappingPairCache = AxisSweep3.new(worldAabbMin,worldAabbMax,maxProxies,nil)
 
#the default constraint solver. For parallel processing you can use a different solver (see Extras/BulletMultiThreaded)
solver = SequentialImpulseConstraintSolver.new    

dynamicsWorld = DiscreteDynamicsWorld.new(dispatcher,overlappingPairCache,solver,collisionConfiguration)
dynamicsWorld.set_gravity(Vector3.new(0,-10,0))

# create a few basic rigid bodies
groundShape = BoxShape.new(Vector3.new(50,50,50))
groundTransform = Transform.get_identity
groundTransform.set_origin Vector3.new(0,-56,0)

localInertia = Vector3.new(0,0,0)

#using motionstate is recommended, it provides interpolation capabilities, and only synchronizes 'active' objects
myMotionState = DefaultMotionState.new groundTransform, Transform.get_identity
motion_states << myMotionState

body = RigidBody.new 0, myMotionState, groundShape, localInertia
body.set_world_transform groundTransform
puts groundTransform.get_origin
puts "body pos=#{body.get_center_of_mass_position} vel=#{body.get_linear_velocity}"
collision_objects << body

#add the body to the dynamics world  
dynamicsWorld.add_rigid_body body

#create a dynamic rigidbody
colShape = SphereShape.new 1

# Create Dynamic Objects
startTransform = Transform.get_identity
colShape.calculate_local_inertia 1.0, localInertia
startTransform.set_origin Vector3.new(2,10,0)

myMotionState = DefaultMotionState.new startTransform, Transform.get_identity
motion_states << myMotionState

body = RigidBody.new 1, myMotionState, colShape, localInertia
puts "body pos=#{body.get_center_of_mass_position} vel=#{body.get_linear_velocity}"
collision_objects << body

dynamicsWorld.add_rigid_body body

#Print out the position of the objects for a few steps
puts "#{dynamicsWorld.get_num_collision_objects} objects in the world"
steps = 9
start = Time.now
steps.times do
  dynamicsWorld.step_simulation(1.0/60.0, 10, 1.0/60.0)
  motion_states.each do |motion_state|
    trans = Transform.new
    motion_state.get_world_transform trans
    puts "world pos = #{trans.get_origin.x},#{trans.get_origin.y},#{trans.get_origin.z}"
  end
end
puts "Took #{Time.now-start}s to do #{steps} steps."

collision_objects.each do |obj|
  dynamicsWorld.remove_collision_object(obj)
end


