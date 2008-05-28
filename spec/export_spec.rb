require File.dirname(__FILE__) + '/spec_helper.rb'

include Bullet

# Time to add your specs!
# http://rspec.rubyforge.org/
describe "Bindings" do

  it "exports Vector3" do
    vector = Vector3.new(0,1,2)
    vector.x.should == 0
    vector.y.should == 1
    vector.z.should == 2
  end
  
  overlappingPairCache = nil
  it "exports AxisSweep" do
    worldAabbMin = Vector3.new(-10000,-10000,-10000)
    worldAabbMax = Vector3.new(10000,10000,10000)
    maxProxies = 1024
    overlappingPairCache = AxisSweep3.new(worldAabbMin,worldAabbMax,maxProxies,nil) 
  end

  dispatcher = nil
  collisionConfiguration = nil
  it "exports DefaultCollisionConfiguration, Dispatcher" do
    collisionConfiguration = DefaultCollisionConfiguration.new(nil,nil,nil)
    dispatcher = CollisionDispatcher.new(collisionConfiguration)
  end
  
  solver = nil
  it "exports Solver" do
    solver = SequentialImpulseConstraintSolver.new
  end
    
  it "exports DiscreteDynamicsWorld" do
    dynamicsWorld = DiscreteDynamicsWorld.new(dispatcher,overlappingPairCache,solver,collisionConfiguration)
    dynamicsWorld.set_gravity(Vector3.new(0,-10,0))
  end
  
  groundShape = nil
  it "exports Shapes" do
    groundShape = BoxShape.new(Vector3.new(50,50,50))
    sphereShape = SphereShape.new 1
  end
  
  groundTransform = nil
  it "exports Transform" do
    groundTransform = Transform.get_identity
    groundTransform.set_origin Vector3.new(0,-56,0)
  end
  
  myMotionState = nil
  it "exports DefaultMotionState" do
    myMotionState = DefaultMotionState.new(groundTransform, Transform.get_identity)
  end
  
  it "exports RigidBody" do
    rbInfo = RigidBody::RigidBodyConstructionInfo.new 0, myMotionState, groundShape, Vector3.new(0,0,0)
    body = RigidBody.new 0, myMotionState, groundShape, Vector3.new(0,0,0)
  end
  
  it "exports Transform" do
    Transform.new.get_origin
  end  
end

