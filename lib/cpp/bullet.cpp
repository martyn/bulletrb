
#include "helper.h"

using namespace Rice;
  
extern "C"
  void Init_bullet() {

  
  Data_Type<btQuadWord> rb_cQuadWord =
    define_module("Bullet")
    .define_class<btQuadWord>("QuadWord")
    .define_method("x", &btQuadWord::x)
    .define_method("y", &btQuadWord::y)
    .define_method("z", &btQuadWord::z)
    .define_method("w", &btQuadWord::w);  

  Data_Type<btVector3> rb_cVector3 =
    define_module("Bullet")
    .define_class<btVector3, btQuadWord>("Vector3")
    .define_constructor(Constructor<btVector3, float, float, float>())
    .define_method("normalize", &btVector3::normalize)
    .define_method("normalized", &btVector3::normalized)
    .define_method("length", &btVector3::length)
    .define_method("dot", &btVector3::dot)
    .define_method("cross", &btVector3::cross)
    .define_method("distance", &btVector3::distance)
    .define_method("angle", &btVector3::angle)
    .define_method("closest_axis", &btVector3::closestAxis)
    .define_method("furthest_axis", &btVector3::furthestAxis)
    .define_method("max_axis", &btVector3::maxAxis)
    .define_method("min_axis", &btVector3::minAxis);  

  Data_Type<btQuaternion> rb_cQuaternion =
    define_module("Bullet")
    .define_class<btQuaternion, btQuadWord>("Quaternion");  

  Data_Type<btCollisionConfiguration> rb_cCollisionConfiguration =
    define_module("Bullet")
    .define_class<btCollisionConfiguration>("CollisionConfiguration");  

  Data_Type<btDefaultCollisionConfiguration> rb_cDefaultCollisionConfiguration =
    define_module("Bullet")
    .define_class<btDefaultCollisionConfiguration, btCollisionConfiguration>("DefaultCollisionConfiguration")
    .define_constructor(Constructor<btDefaultCollisionConfiguration>())
    .define_method("get_persistent_manifold_pool", &btDefaultCollisionConfiguration::getPersistentManifoldPool)
    .define_method("get_collision_algorithm_pool", &btDefaultCollisionConfiguration::getCollisionAlgorithmPool)
    .define_method("get_stack_allocator", &btDefaultCollisionConfiguration::getStackAllocator)
    .define_method("get_collision_algorithm_create_func", &btDefaultCollisionConfiguration::getCollisionAlgorithmCreateFunc);  

  Data_Type<btDispatcher> rb_cDispatcher =
    define_module("Bullet")
    .define_class<btDispatcher>("Dispatcher")
    .define_method("clear_manifold", &btDispatcher::clearManifold)
    .define_method("dispatch_all_collision_pairs", &btDispatcher::dispatchAllCollisionPairs)
    .define_method("find_algorithm", &btDispatcher::findAlgorithm)
    .define_method("free_collision_algorithm", &btDispatcher::freeCollisionAlgorithm)
    .define_method("get_internal_manifold_pointer", &btDispatcher::getInternalManifoldPointer)
    .define_method("get_manifold_by_index_internal", &btDispatcher::getManifoldByIndexInternal)
    .define_method("get_new_manifold", &btDispatcher::getNewManifold)
    .define_method("get_num_manifolds", &btDispatcher::getNumManifolds)
    .define_method("needs_collision", &btDispatcher::needsCollision)
    .define_method("needs_response", &btDispatcher::needsResponse)
    .define_method("release_manifold", &btDispatcher::releaseManifold);  

  Data_Type<btOverlappingPairCache> rb_cOverlappingPairCache =
    define_module("Bullet")
    .define_class<btOverlappingPairCache>("OverlappingPairCache")
    .define_constructor(Constructor<btOverlappingPairCache>());  

  Data_Type<btCollisionDispatcher> rb_cCollisionDispatcher =
    define_module("Bullet")
    .define_class<btCollisionDispatcher, btDispatcher>("CollisionDispatcher")
    .define_constructor(Constructor<btCollisionDispatcher, btCollisionConfiguration*>())
    .define_method("get_internal_manifold_pointer", &btCollisionDispatcher::getInternalManifoldPointer)
    .define_method("get_num_manifolds", &btCollisionDispatcher::getNumManifolds)
    .define_method("register_collision_create_func", &btCollisionDispatcher::registerCollisionCreateFunc)
    .define_method("set_collision_configuration", &btCollisionDispatcher::setCollisionConfiguration);  

  Data_Type<btBroadphaseInterface> rb_cBroadphaseInterface =
    define_module("Bullet")
    .define_class<btBroadphaseInterface>("BroadphaseInterface");  

  Data_Type<btAxisSweep3> rb_cAxisSweep3 =
    define_module("Bullet")
    .define_class<btAxisSweep3, btBroadphaseInterface>("AxisSweep3")
    .define_constructor(Constructor<btAxisSweep3, btPoint3&, btPoint3&, int, btOverlappingPairCache*>())
    .define_method("calculate_overlapping_pairs", &btAxisSweep3::calculateOverlappingPairs)
    .define_method("create_proxy", &btAxisSweep3::createProxy)
    .define_method("destroy_proxy", &btAxisSweep3::destroyProxy)
    .define_method("set_aabb", &btAxisSweep3::setAabb);  

  Data_Type<btConstraintSolver> rb_cConstraintSolver =
    define_module("Bullet")
    .define_class<btConstraintSolver>("ConstraintSolver")
    .define_method("prepare_solve", &btConstraintSolver::prepareSolve);  

  Data_Type<btSequentialImpulseConstraintSolver> rb_cSequentialImpulseConstraintSolver =
    define_module("Bullet")
    .define_class<btSequentialImpulseConstraintSolver, btConstraintSolver>("SequentialImpulseConstraintSolver")
    .define_constructor(Constructor<btSequentialImpulseConstraintSolver>())
    .define_method("bt_rand2", &btSequentialImpulseConstraintSolver::btRand2)
    .define_method("bt_rand_int2", &btSequentialImpulseConstraintSolver::btRandInt2)
    .define_method("get_rand_seed", &btSequentialImpulseConstraintSolver::getRandSeed)
    .define_method("get_solver_mode", &btSequentialImpulseConstraintSolver::getSolverMode)
    .define_method("reset", &btSequentialImpulseConstraintSolver::reset)
    .define_method("set_rand_seed", &btSequentialImpulseConstraintSolver::setRandSeed)
    .define_method("set_solver_mode", &btSequentialImpulseConstraintSolver::setSolverMode);  

  Data_Type<btCollisionWorld> rb_cCollisionWorld =
    define_module("Bullet")
    .define_class<btCollisionWorld>("CollisionWorld")
    .define_method("add_collision_object", &btCollisionWorld::addCollisionObject)
    .define_method("get_broadphase", &btCollisionWorld::getBroadphase)
    .define_method("get_debug_drawer", &btCollisionWorld::getDebugDrawer)
    .define_method("get_dispatcher", &btCollisionWorld::getDispatcher)
    .define_method("get_num_collision_objects", &btCollisionWorld::getNumCollisionObjects)
    .define_method("get_pair_cache", &btCollisionWorld::getPairCache)
    .define_method("ray_test", &btCollisionWorld::rayTest)
    .define_method("ray_test_single", &btCollisionWorld::rayTestSingle)
    .define_method("remove_collision_object", &btCollisionWorld::removeCollisionObject)
    .define_method("perform_discrete_collision_detection", &btCollisionWorld::performDiscreteCollisionDetection)
    .define_method("object_query_single", &btCollisionWorld::objectQuerySingle)
    .define_method("set_debug_drawer", &btCollisionWorld::setDebugDrawer)
    .define_method("update_aabbs", &btCollisionWorld::updateAabbs);  

  Data_Type<btDynamicsWorld> rb_cDynamicsWorld =
    define_module("Bullet")
    .define_class<btDynamicsWorld, btCollisionWorld>("DynamicsWorld")
    .define_method("add_rigid_body", &btDynamicsWorld::addRigidBody)
    .define_method("clear_forces", &btDynamicsWorld::clearForces)
    .define_method("debug_draw_world", &btDynamicsWorld::debugDrawWorld)
    .define_method("get_constraint_solver", &btDynamicsWorld::getConstraintSolver)
    .define_method("get_num_constraints", &btDynamicsWorld::getNumConstraints)
    .define_method("remove_rigid_body", &btDynamicsWorld::removeRigidBody)
    .define_method("set_gravity", &btDynamicsWorld::setGravity)
    .define_method("step_simulation", &btDynamicsWorld::stepSimulation);  

  Data_Type<btCollisionShape> rb_cCollisionShape =
    define_module("Bullet")
    .define_class<btCollisionShape>("CollisionShape")
    .define_method("calculate_local_inertia", &btCollisionShape::calculateLocalInertia);  

  Data_Type<btPolyhedralConvexShape> rb_cPolyhedralConvexShape =
    define_module("Bullet")
    .define_class<btPolyhedralConvexShape, btCollisionShape>("PolyhedralConvexShape")
    .define_method("get_nonvirtual_aabb", &btPolyhedralConvexShape::getNonvirtualAabb)
    .define_method("get_vertex", &btPolyhedralConvexShape::getVertex)
    .define_method("get_edge", &btPolyhedralConvexShape::getEdge)
    .define_method("get_num_edges", &btPolyhedralConvexShape::getNumEdges)
    .define_method("get_num_vertices", &btPolyhedralConvexShape::getNumVertices);  

  Data_Type<btConvexShape> rb_cConvexShape =
    define_module("Bullet")
    .define_class<btConvexShape, btCollisionShape>("ConvexShape");  

  Data_Type<btDiscreteDynamicsWorld> rb_cDiscreteDynamicsWorld =
    define_module("Bullet")
    .define_class<btDiscreteDynamicsWorld, btDynamicsWorld>("DiscreteDynamicsWorld")
    .define_constructor(Constructor<btDiscreteDynamicsWorld, btDispatcher*, btBroadphaseInterface*, btConstraintSolver*, btCollisionConfiguration*>())
    .define_method("add_constraint", &btDiscreteDynamicsWorld::addConstraint)
    .define_method("add_vehicle", &btDiscreteDynamicsWorld::addVehicle)
    .define_method("apply_gravity", &btDiscreteDynamicsWorld::applyGravity)
    .define_method("debug_draw_object", &btDiscreteDynamicsWorld::debugDrawObject)
    .define_method("get_collision_world", &btDiscreteDynamicsWorld::getCollisionWorld)
    .define_method("remove_constraint", &btDiscreteDynamicsWorld::removeConstraint)
    .define_method("remove_vehicle", &btDiscreteDynamicsWorld::removeVehicle)
    .define_method("set_gravity", &btDiscreteDynamicsWorld::setGravity);  

  Data_Type<btCollisionObject> rb_cCollisionObject =
    define_module("Bullet")
    .define_class<btCollisionObject>("CollisionObject");  

  Data_Type<btRigidBody::btRigidBodyConstructionInfo> rb_cRigidBodyConstructionInfo =
    define_module("Bullet")
    .define_class<btRigidBody::btRigidBodyConstructionInfo>("RigidBodyConstructionInfo")
    .define_constructor(Constructor<btRigidBody::btRigidBodyConstructionInfo, btScalar, btMotionState*, btCollisionShape*, btVector3&>());  

  Rice::Enum<btDynamicsWorldType> rb_cDynamicsWorldType =
    define_enum<btDynamicsWorldType>("DynamicsWorldType")
    .define_value("SIMPLE_DYNAMICS_WORLD", BT_SIMPLE_DYNAMICS_WORLD)
    .define_value("DISCRETE_DYNAMICS_WORLD", BT_DISCRETE_DYNAMICS_WORLD)
    .define_value("CONTINUOUS_DYNAMICS_WORLD", BT_CONTINUOUS_DYNAMICS_WORLD);  

  Data_Type<btSimulationIslandManager> rb_cSimulationIslandManager =
    define_module("Bullet")
    .define_class<btSimulationIslandManager>("SimulationIslandManager")
    .define_constructor(Constructor<btSimulationIslandManager>());  

  Data_Type<btBoxShape> rb_cBoxShape =
    define_module("Bullet")
    .define_class<btBoxShape, btPolyhedralConvexShape>("BoxShape")
    .define_constructor(Constructor<btBoxShape, btVector3&>())
    .define_method("get_aabb", &btBoxShape::getAabb)
    .define_method("get_margin", &btBoxShape::getMargin)
    .define_method("get_name", &btBoxShape::getName)
    .define_method("get_num_planes", &btBoxShape::getNumPlanes)
    .define_method("get_num_preferred_penetration_directions", &btBoxShape::getNumPreferredPenetrationDirections)
    .define_method("get_plane", &btBoxShape::getPlane)
    .define_method("get_preferred_penetration_direction", &btBoxShape::getPreferredPenetrationDirection)
    .define_method("get_shape_type", &btBoxShape::getShapeType)
    .define_method("is_inside", &btBoxShape::isInside)
    .define_method("set_local_scaling", &btBoxShape::setLocalScaling)
    .define_method("set_margin", &btBoxShape::setMargin);  

  Data_Type<btConvexInternalShape> rb_cConvexInternalShape =
    define_module("Bullet")
    .define_class<btConvexInternalShape, btConvexShape>("ConvexInternalShape")
    .define_method("batched_unit_vector_get_supporting_vertex_without_margin", &btConvexInternalShape::batchedUnitVectorGetSupportingVertexWithoutMargin)
    .define_method("get_aabb", &btConvexInternalShape::getAabb)
    .define_method("get_aabb_slow", &btConvexInternalShape::getAabbSlow)
    .define_method("get_num_preferred_penetration_directions", &btConvexInternalShape::getNumPreferredPenetrationDirections)
    .define_method("set_local_scaling", &btConvexInternalShape::setLocalScaling)
    .define_method("set_margin", &btConvexInternalShape::setMargin);  

  Data_Type<btTransform> rb_cTransform =
    define_module("Bullet")
    .define_class<btTransform>("Transform")
    .define_constructor(Constructor<btTransform>())
    .define_singleton_method("get_identity", &Transform_GetIdentity)
    .define_method("get_origin", &Transform_GetOrigin)
    .define_method("set_identity", &btTransform::setIdentity)
    .define_method("set_origin", &btTransform::setOrigin);  

  Data_Type<btSphereShape> rb_cSphereShape =
    define_module("Bullet")
    .define_class<btSphereShape, btConvexInternalShape>("SphereShape")
    .define_constructor(Constructor<btSphereShape, btScalar>())
    .define_method("calculate_local_inertia", &btSphereShape::calculateLocalInertia)
    .define_method("get_name", &btSphereShape::getName)
    .define_method("get_radius", &btSphereShape::getRadius)
    .define_method("get_shape_type", &btSphereShape::getShapeType);  

  Data_Type<btMotionState> rb_cMotionState =
    define_module("Bullet")
    .define_class<btMotionState>("MotionState")
    .define_method("get_world_transform", &btMotionState::getWorldTransform)
    .define_method("set_world_transform", &btMotionState::setWorldTransform);  

  Data_Type<btDefaultMotionState> rb_cDefaultMotionState =
    define_module("Bullet")
    .define_class<btDefaultMotionState, btMotionState>("DefaultMotionState")
    .define_constructor(Constructor<btDefaultMotionState, btTransform&, btTransform&>());  

  Data_Type<btRigidBody> rb_cRigidBody =
    define_module("Bullet")
    .define_class<btRigidBody, btCollisionObject>("RigidBody")
    .define_constructor(Constructor<btRigidBody, btRigidBody::btRigidBodyConstructionInfo>())
    .define_method("get_center_of_mass_position", &RigidBody_GetCenterOfMassPosition)
    .define_method("get_orientation", &RigidBody_GetOrientation);  

  Data_Type<btConcaveShape> rb_cConcaveShape =
    define_module("Bullet")
    .define_class<btConcaveShape, btCollisionShape>("ConcaveShape")
    .define_method("get_margin", &btConcaveShape::getMargin)
    .define_method("process_all_triangles", &btConcaveShape::processAllTriangles)
    .define_method("set_margin", &btConcaveShape::setMargin);  

  Data_Type<btStaticPlaneShape> rb_cStaticPlaneShape =
    define_module("Bullet")
    .define_class<btStaticPlaneShape, btConcaveShape>("StaticPlaneShape")
    .define_constructor(Constructor<btStaticPlaneShape, btVector3&, btScalar>())
    .define_method("calculate_local_inertia", &btStaticPlaneShape::calculateLocalInertia)
    .define_method("get_aabb", &btStaticPlaneShape::getAabb)
    .define_method("get_name", &btStaticPlaneShape::getName)
    .define_method("get_plane_constant", &btStaticPlaneShape::getPlaneConstant)
    .define_method("get_shape_type", &btStaticPlaneShape::getShapeType)
    .define_method("process_all_triangles", &btStaticPlaneShape::processAllTriangles)
    .define_method("set_local_scaling", &btStaticPlaneShape::setLocalScaling);  

    }
