#ifndef BULLET_HELPER
#define BULLET_HELPER

#include <vector>

#include "bullet_namespace.h"

#include "rice/Class.hpp"
#include "rice/Data_Type.hpp"
#include "rice/Constructor.hpp"
#include "rice/Enum.hpp"
#include "rice/to_from_ruby.hpp"
#include "rice/Address_Registration_Guard.hpp"

#include <ruby.h>

template<>
Rice::Object to_ruby<btManifoldPoint>(btManifoldPoint const & x);

template<>
Rice::Object to_ruby<btAlignedObjectArray<btBroadphaseInterface*> >(btAlignedObjectArray<btBroadphaseInterface*> const & x);

template<>
Rice::Object to_ruby<btAlignedObjectArray<btCollisionObject*> >(btAlignedObjectArray<btCollisionObject*> const & x);

template<>
Rice::Object to_ruby<btMatrix3x3>(btMatrix3x3 const & x);

template<>
Rice::Object to_ruby<btTransform>(btTransform const & x); 

template<>
Rice::Object to_ruby<btVector3>(btVector3 const & x);

template<>
Rice::Object to_ruby<btQuaternion>(btQuaternion const & x);

template<>
Rice::Object to_ruby<btUnionFind>(btUnionFind const & x);

template<>
Rice::Object to_ruby<btDispatcherInfo>(btDispatcherInfo const & x);

template<>
Rice::Object to_ruby<btRigidBody>(btRigidBody const & x);

template<>
Rice::Object to_ruby<btDynamicsWorldType>(btDynamicsWorldType const & x);

//template<>
//Rice::Object to_ruby<btTriangle>(btTriangle const & x) ;

template<>
Rice::Object to_ruby<btTypedConstraintType>(btTypedConstraintType const & x);

template<>
Rice::Object to_ruby<btWheelInfo>(btWheelInfo const & x);

template<>
Rice::Object to_ruby<unsigned short>(const unsigned short& x);

template<>
Rice::Object to_ruby<btBvhSubtreeInfo>(btBvhSubtreeInfo const & x);

template<>
Rice::Object to_ruby<btVector4>(btVector4 const & x);

template<>
Rice::Object to_ruby<btContactSolverInfo>(btContactSolverInfo const & x);

template<> 
btOverlappingPairCache* from_ruby<btOverlappingPairCache*>(Rice::Object x);

template<> 
btPoolAllocator* from_ruby<btPoolAllocator*>(Rice::Object x);

template<> 
btStackAlloc* from_ruby<btStackAlloc*>(Rice::Object x);

template<>
unsigned short from_ruby<unsigned short>(Rice::Object x);

template<>
float const& from_ruby<float const&>(Rice::Object x);

btTransform *Transform_GetIdentity(Rice::Object self);

btVector3 *Transform_GetOrigin(btTransform *self);

btTransform *CollisionObject_GetWorldTransform(btCollisionObject *self);


// Keep track of your own damn motion state objects!!
// btMotionState *RigidBody_GetMotionState(btRigidBody *self) {
//   return self->getMotionState();
// }

// Keep track of your own damn collision objects!!
//Rice::Array CollisionWorld_GetCollisionObjectArray(btCollisionWorld *self) {
//  Rice::Array array;
//  for(int i = 0; i < self->getNumCollisionObjects(); i++) {
//    array.push<btCollisionObject*>(self->getCollisionObjectArray()[i]);
//  }
//  return array;
//}


#endif
