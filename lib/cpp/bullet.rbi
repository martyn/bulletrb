class QuadWord
  def x
  def y
  def z
  def w

class Vector3 < QuadWord
  def initialize(float, float, float)

class Quaternion < QuadWord

class CollisionConfiguration

class DefaultCollisionConfiguration < CollisionConfiguration
#  def initialize(StackAlloc*, PoolAllocator*, PoolAllocator*)
  def initialize
  def getPersistentManifoldPool
  def getCollisionAlgorithmPool
  def getStackAllocator
  def getCollisionAlgorithmCreateFunc(int, int)

  
class CollisionDispatcher < Dispatcher
#  def initialize
  def initialize(btCollisionConfiguration*)
#  def allocateCollisionAlgorithm(int)
#  def clearManifold(PersistentManifold*)
##  def defaultNearCallback(BroadphasePair&, CollisionDispatcher&, DispatcherInfo&)
#  def dispatchAllCollisionPairs(OverlappingPairCache*, DispatcherInfo&, Dispatcher*)
#  def findAlgorithm(CollisionObject*, CollisionObject*, PersistentManifold*)
#  def freeCollisionAlgorithm(void*)
#  def getCollisionConfiguration - these don't work because they don't take arguments
#  def getCollisionConfiguration - and are overloaded with const
  def getInternalManifoldPointer
#  def getManifoldByIndexInternal(int)
#  def getManifoldByIndexInternal(int)
##  def getNearCallback - function pointer
#  def getNewManifold(void*, void*)
  def getNumManifolds
#  def needsCollision(CollisionObject*, CollisionObject*)
#  def needsResponse(CollisionObject*, CollisionObject*)
  def registerCollisionCreateFunc(int, int, CollisionAlgorithmCreateFunc*)
#  def releaseManifold(PersistentManifold*)
  def setCollisionConfiguration(CollisionConfiguration*)
#  def setNearCallback(btNearCallback) - requests function pointer

class OverlappingPairCache
  def initialize

class Dispatcher
#  def initialize
#  def allocateCollisionAlgorithm(int) --returns void *
  def clearManifold(PersistentManifold*)
  def dispatchAllCollisionPairs(OverlappingPairCache*, DispatcherInfo&, Dispatcher*)
  def findAlgorithm(CollisionObject*, CollisionObject*, PersistentManifold*)
  def freeCollisionAlgorithm(void*)
  def getInternalManifoldPointer
  def getManifoldByIndexInternal(int)
  def getNewManifold(void*, void*)
  def getNumManifolds
  def needsCollision(CollisionObject*, CollisionObject*)
  def needsResponse(CollisionObject*, CollisionObject*)
  def releaseManifold(PersistentManifold*)

class AxisSweep3 < BroadphaseInterface#< AxisSweep3Internal - AxisSweep3Internal throws an error?!?
  def initialize(btPoint3&, btPoint3&, int, btOverlappingPairCache*)
  def calculateOverlappingPairs(btDispatcher*)
  def createProxy(btVector3&, btVector3&, int, void*, short, short, btDispatcher*)
  def destroyProxy(btBroadphaseProxy*, btDispatcher*)
#  def getOverlappingPairCache -
#  def getOverlappingPairCache - overloaded const
  def setAabb(btBroadphaseProxy*, btVector3&, btVector3&, btDispatcher*)

#class AxisSweep3Internal < BroadphaseInterface

class BroadphaseInterface
#  def initialize


#class StackAlloc

class SequentialImpulseConstraintSolver < ConstraintSolver
  def initialize
#  def SetFrictionSolverFunc(ContactSolverFunc, int, int)
  def btRand2
  def btRandInt2(int)
  def getRandSeed
  def getSolverMode
  def reset
#  def setContactSolverFunc(ContactSolverFunc, int, int)
  def setRandSeed(unsigned)
  def setSolverMode(int)
#  def solveCombinedContactFriction(btRigidBody*, btRigidBody*, btManifoldPoint&, btContactSolverInfo&, int, btIDebugDraw*) - needs many classes defined.
  # def solveGroup(btCollisionObject**, int, btPersistentManifold**, int, btTypedConstraint**, int, btContactSolverInfo&, btIDebugDraw*, btStackAlloc*, btDispatcher*)
  # def solveGroupCacheFriendly(btCollisionObject**, int, btPersistentManifold**, int, btTypedConstraint**, int, btContactSolverInfo&, btIDebugDraw*, btStackAlloc*)
  # def solveGroupCacheFriendlyIterations(btCollisionObject**, int, btPersistentManifold**, int, btTypedConstraint**, int, btContactSolverInfo&, btIDebugDraw*, btStackAlloc*)
  # def solveGroupCacheFriendlySetup(btCollisionObject**, int, btPersistentManifold**, int, btTypedConstraint**, int, btContactSolverInfo&, btIDebugDraw*, btStackAlloc*)
  
  
class ConstraintSolver
  def prepareSolve(int, int)
  
class DiscreteDynamicsWorld < DynamicsWorld
#  def initialize
  def initialize(btDispatcher*, btBroadphaseInterface*, btConstraintSolver*, btCollisionConfiguration*)
  def addConstraint(btTypedConstraint*, bool)
#  def addRigidBody(btRigidBody*)
#  def addRigidBody(btRigidBody*, short, short)
  def addVehicle(btRaycastVehicle*)
  def applyGravity
#  def calculateSimulationIslands - protected
#  def clearForces
  def debugDrawObject(btTransform&, btCollisionShape*, btVector3&)
#  def debugDrawSphere(btScalar, btTransform&, btVector3&) - protected
#  def debugDrawWorld
  def getCollisionWorld
#  def getConstraint(int)
#  def getConstraint(int)
#  def getConstraintSolver
#  def getGravity
#  def getNumConstraints
#  def getSimulationIslandManager
#  def getSimulationIslandManager -overloaded
#  def getSolverInfo --getting error
#  def getWorldType
#  def integrateTransforms(btScalar) -protected
#  def internalSingleStepSimulation(btScalar) -protected
#  def predictUnconstraintMotion(btScalar) -protected
  def removeConstraint(btTypedConstraint*)
#  def removeRigidBody(btRigidBody*)
  def removeVehicle(btRaycastVehicle*)
#  def saveKinematicState(btScalar) -protected
#  def setConstraintSolver(btConstraintSolver*)
  def setGravity(btVector3&)
#  def solveConstraints(btContactSolverInfo&) -protected
#  def startProfiling(btScalar) -protected
#  def synchronizeMotionStates -protected
#  def updateActivationState(btScalar) -protected
#  def updateVehicles(btScalar) -protected

class DynamicsWorld < CollisionWorld
#  def initialize(btDispatcher*, btBroadphaseInterface*, btCollisionConfiguration*)
#  def initialize
  def addRigidBody(btRigidBody*)
  def clearForces
  def debugDrawWorld
  def getConstraintSolver
#  def getGravity - getting error
  def getNumConstraints
#  def getWorldType - getting error
  def removeRigidBody(btRigidBody*)
#  def setConstraintSolver(btConstraintSolver*) -- getting error
  def setGravity(btVector3&)
  def stepSimulation( btScalar timeStep,int maxSubSteps, btScalar fixedTimeStep)
  
class ConvexShape < CollisionShape

class PolyhedralConvexShape < CollisionShape
  def getNonvirtualAabb(btTransform&, btVector3&, btVector3&, btScalar)    
  def getVertex(int i, btPoint3 &vtx)
  def getEdge(int i, btPoint3 &pa, btPoint3 &pb)
  def getNumEdges
  def getNumVertices  

class CollisionShape
  def calculateLocalInertia(btScalar,btVector3&)

class CollisionWorld
#  def initialize(btDispatcher*, btBroadphaseInterface*, btCollisionConfiguration*)
  def addCollisionObject(btCollisionObject*, short, short)
  def getBroadphase
#  def getCollisionObjectArray => CollisionWorld_GetCollisionObjectArray
  def getDebugDrawer
  def getDispatcher
  #def getDispatchInfo
  def getNumCollisionObjects
  def getPairCache
  def rayTest(btVector3&, btVector3&, RayResultCallback&, short)
  def rayTestSingle
  def removeCollisionObject(btCollisionObject*)
  def performDiscreteCollisionDetection
  def objectQuerySingle
  def setDebugDrawer(btIDebugDraw*)
  def updateAabbs
  
class RigidBody < CollisionObject
  def initialize(btRigidBody::btRigidBodyConstructionInfo)
#  def initialize(btScalar, btMotionState*, btCollisionShape*, btVector3&)
 # def getGravity - error
#  def getMotionState => RigidBody_GetMotionState -- keep track of your own objects, as you create them.  This crashes.
 # def setGravity(btVector3&) - error
  def getCenterOfMassPosition => RigidBody_GetCenterOfMassPosition
  def getOrientation => RigidBody_GetOrientation
    
class RigidBody::RigidBodyConstructionInfo
  def initialize(btScalar, btMotionState*, btCollisionShape*, btVector3&)
#  def addConstraintRef(btTypedConstraint*)
#  def applyCentralForce(btVector3&)
#  def applyCentralImpulse(btVector3&)
#  def applyDamping(btScalar)
#  def applyForce(btVector3&, btVector3&)
#  def applyGravity
#  def applyImpulse(btVector3&, btVector3&)
#  def applyTorque(btVector3&)
#  def applyTorqueImpulse(btVector3&)
#  def checkCollideWithOverride(btCollisionObject*)
#  def clearForces
#  def computeAngularImpulseDenominator(btVector3&)
#  def computeImpulseDenominator(btPoint3&, btVector3&)
#  def cross
#  def dot(vec))
#  def dot(vec))
#  def getAabb(btVector3&, btVector3&)
#  def getActivationState
#  def getActivationState
#  def getActivationState
#  def getAngularFactor
#  def getAngularVelocity
#  def getBroadphaseProxy
#  def getBroadphaseProxy
#  def getBroadphaseProxy
#  def getCenterOfMassTransform
#  def getCollisionShape
#  def getCollisionShape
#  def getConstraintRef(int)
#  def getGravity
#  def getInvInertiaDiagLocal
#  def getInvInertiaTensorWorld
#  def getInvInertiaTensorWorld
#  def getInvMass
#  def getLinearVelocity
#  def getMotionState
#  def getMotionState
#  def getNumConstraintRefs
#  def getOrigin
#  def getOrigin
#  def getVelocityInLocalPoint(btVector3&)
#  def integrateVelocities(btScalar)
#  def internalApplyImpulse(btVector3&, btVector3&, btScalar)
#  def isInWorld
#  def length2
#  def length2
#  def predictIntegratedTransform(btScalar, btTransform&)
#  def proceedToTransform(btTransform&)
#  def removeConstraintRef(btTypedConstraint*)
#  def saveKinematicState(btScalar)
#  def setAngularFactor(btScalar)
#  def setAngularVelocity(btVector3&)
#  def setCenterOfMassTransform(btTransform&)
#  def setDamping(btScalar, btScalar)
#  def setGravity(btVector3&)
#  def setIdentity
#  def setInvInertiaDiagLocal(btVector3&)
#  def setLinearVelocity(btVector3&)
#  def setMassProps(btScalar, btVector3&)
#  def setMotionState(btMotionState*)
#  def setNewBroadphaseProxy(btBroadphaseProxy*)
#  def setSleepingThresholds(btScalar, btScalar)
#  def setupRigidBody(btRigidBodyConstructionInfo&)
#  def size
#  def size
#  def translate(btVector3&)
#  def upcast(btCollisionObject*)
#  def upcast(btCollisionObject*)
#  def updateDeactivation(btScalar)
#  def updateInertiaTensor
#  def wantsSleeping

  
enum DynamicsWorldType
  def SIMPLE_DYNAMICS_WORLD
	def DISCRETE_DYNAMICS_WORLD 
	def CONTINUOUS_DYNAMICS_WORLD
	
class SimulationIslandManager
  def initialize
  
class BoxShape < PolyhedralConvexShape
  def initialize(btVector3&)
#  def batchedUnitVectorGetSupportingVertexWithoutMargin(btVector3*, btVector3*, int) -- inversion of get
  # def calculateLocalInertia(btScalar, btVector3&) -- defined in CollisionShape
  def getAabb(btTransform&, btVector3&, btVector3&)
#  def getEdge(int, btPoint3&, btPoint3&) -- inversion of get
#  def getHalfExtentsWithMargin -- returns const (?)
#  def getHalfExtentsWithoutMargin -- returns const (?)
  def getMargin
  def getName
  def getNumPlanes
  def getNumPreferredPenetrationDirections  
  def getPlane(btVector3&, btPoint3&, int)
  # def getPlaneEquation(btVector4&, int) - inversion of get
  def getPreferredPenetrationDirection(int, btVector3&)
  def getShapeType
  # def getVertex(int, btVector3&) -- inversion of get/ returns void
  def isInside(btPoint3&, btScalar)
  # def localGetSupportingVertex(btVector3&) -- returns const (?)
  # def localGetSupportingVertexWithoutMargin(btVector3&) -- returns const (?)
  def setLocalScaling(btVector3&)
  def setMargin(btScalar)
  
class SphereShape < ConvexInternalShape
  def initialize(btScalar)
  #def batchedUnitVectorGetSupportingVertexWithoutMargin(btVector3*, btVector3*, int)
  def calculateLocalInertia(btScalar, btVector3&)
  #def getAabb(btTransform&, btVector3&, btVector3&)
  #def getMargin
  def getName
  def getRadius
  def getShapeType
  #def localGetSupportingVertex(btVector3&)
  #def localGetSupportingVertexWithoutMargin(btVector3&)
  #def setMargin(btScalar)
  #def setMargin(margin))
  
class Transform
  def initialize
#  def getBasis
#  def getBasis  - overloaded
  def self.getIdentity 
  def getOrigin => Transform_GetOrigin
#  def getOrigin
#  def getOrigin - overloaded
#  def getRotation -error
#  def invXform(btVector3&)
#  def invXform(btVector3&) -overloaded
#  def inverse -error
#  def inverseTimes(btTransform&)
#  def inverseTimes(btTransform&) -overloaded
#  def mult(btTransform&, btTransform&) -error
#  def operator*(btTransform&)
#  def operator*(btVector3&)
#  def operator*(btTransform&) -overloaded
#  def operator*=(btTransform&) -operators need fixing
#  def operator=(btTransform&)
#  def setBasis(btMatrix3x3&) -error
  def setIdentity
  def setOrigin(btVector3&)
#  def setRotation(btQuaternion&) -error
#  def transpose -overloaded
#  def transpose
#  def x -overloaded
#  def x
#  def y
#  def y
#  def z
#  def z

class ConvexInternalShape < ConvexShape
  def batchedUnitVectorGetSupportingVertexWithoutMargin(btVector3*, btVector3*, int)
  def getAabb(btTransform&, btVector3&, btVector3&)
  def getAabbSlow(btTransform&, btVector3&, btVector3&)
  # def getImplicitShapeDimensions
  # def getLocalScaling
  # def getLocalScalingNV
  # def getMargin
  # def getMarginNV
  def getNumPreferredPenetrationDirections
  # def getPreferredPenetrationDirection(int, btVector3&)
  # def localGetSupportingVertex(btVector3&)
  # def localGetSupportingVertexWithoutMargin(btVector3&)
  def setLocalScaling(btVector3&)
  def setMargin(btScalar)
  

class DefaultMotionState < MotionState
#  def initialize
  def initialize (btTransform&, btTransform&)

#  def getWorldTransform(btTransform&)
#  def setWorldTransform(btTransform&)

class MotionState
  def getWorldTransform(btTransform&)
  def setWorldTransform(btTransform&)

class CollisionObject

class StaticPlaneShape < ConcaveShape
  def initialize(btVector3&, btScalar)
  def calculateLocalInertia(btScalar, btVector3&)
  def getAabb(btTransform&, btVector3&, btVector3&)
  # def getLocalScaling
  def getName
  def getPlaneConstant
  # def getPlaneNormal - needs to_ruby_<btVector3>::convert(const btVector3&)
  def getShapeType
  def processAllTriangles(btTriangleCallback*, btVector3&, btVector3&)
  def setLocalScaling(btVector3&)

class ConcaveShape < CollisionShape
  def getMargin
  def processAllTriangles(btTriangleCallback*, btVector3&, btVector3&)
  def setMargin(btScalar)
