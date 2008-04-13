#include <vector>

#include "btBulletCollisionCommon.h"
#include "btBulletDynamicsCommon.h"
#include "BulletCollision/CollisionDispatch/btSimulationIslandManager.h"
#include "BulletCollision/CollisionDispatch/btCollisionCreateFunc.h"
#include "LinearMath/btAlignedObjectArray.h"

#include "rice/Class.hpp"
#include "rice/Data_Type.hpp"
#include "rice/Constructor.hpp"
#include "rice/Enum.hpp"
#include "rice/to_from_ruby.hpp"
#include "rice/Address_Registration_Guard.hpp"

#include <ruby.h>

template<>
Rice::Object to_ruby<btMatrix3x3>(btMatrix3x3 const & x) {
	return to_ruby(new btMatrix3x3(x));
}

template<>
Rice::Object to_ruby<btTransform>(btTransform const & x) {
	return to_ruby(new btTransform(x));
}

template<>
Rice::Object to_ruby<btVector3>(btVector3 const & x) {
	return to_ruby(new btVector3(x));
}

template<>
Rice::Object to_ruby<btQuaternion>(btQuaternion const & x) {
	return to_ruby(new btQuaternion(x));
}

template<> 
btOverlappingPairCache* from_ruby<btOverlappingPairCache*>(Rice::Object x) {
  if(x == Rice::Nil)
    return 0;
  
  if(std::string("Bullet::OverlappingPairCache") == x.class_of().name().c_str())
    return (btOverlappingPairCache*)&x;

  std::string s("Unable to convert ");
  s += x.class_of().name().c_str();
  s += " to ";
  s += "btOverlappingPairCache*";
  throw std::invalid_argument(s.c_str());
}

btTransform *Transform_GetIdentity(Rice::Object self) {
  	btTransform *tr = new btTransform();
		tr->setIdentity();
		return tr;
}

btVector3 *Transform_GetOrigin(btTransform *self) {
  return new btVector3(self->getOrigin());
}

btTransform *CollisionObject_GetWorldTransform(btCollisionObject *self) {
	return new btTransform(self->getWorldTransform());
}


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
