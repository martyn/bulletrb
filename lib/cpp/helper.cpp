
#include "rice/Class.hpp"
#include "rice/Data_Type.hpp"
#include "rice/Constructor.hpp"
#include "rice/Enum.hpp"
#include "rice/to_from_ruby.hpp"
#include "rice/Address_Registration_Guard.hpp"

#include <ruby.h>

#include "../helper.h"

#include <iostream>

template<>
Rice::Object to_ruby<btMatrix3x3>(btMatrix3x3 const & x) {
	return Rice::Data_Object<btMatrix3x3>((btMatrix3x3 *)&x, Rice::Data_Type<btMatrix3x3>::klass(), 0, 0);
}

template<>
Rice::Object to_ruby<btTransform>(btTransform const & x) {
	return Rice::Data_Object<btTransform>((btTransform *)&x, Rice::Data_Type<btTransform>::klass(), 0, 0);
}

template<>
Rice::Object to_ruby<btVector3>(btVector3 const & x) {
	return Rice::Data_Object<btVector3>((btVector3 *)&x, Rice::Data_Type<btVector3>::klass(), 0, 0);
}

template<>
Rice::Object to_ruby<btQuaternion>(btQuaternion const & x) {
	return Rice::Data_Object<btQuaternion>((btQuaternion *)&x, Rice::Data_Type<btQuaternion>::klass(), 0, 0);
}

//template<>
//Rice::Object to_ruby<btUnionFind>(btUnionFind const & x) {
//	return Rice::Data_Object<btUnionFind>((btUnionFind *)&x, Rice::Data_Type<btUnionFind>::klass(), 0, 0);
//}

template<>
Rice::Object to_ruby<btDispatcherInfo>(btDispatcherInfo const & x) {
	return Rice::Data_Object<btDispatcherInfo>((btDispatcherInfo *)&x, Rice::Data_Type<btDispatcherInfo>::klass(), 0, 0);
}

template<>
Rice::Object to_ruby<btRigidBody>(btRigidBody const & x) {
	return Rice::Data_Object<btRigidBody>((btRigidBody *)&x, Rice::Data_Type<btRigidBody>::klass(), 0, 0);
}

template<>
Rice::Object to_ruby<btDynamicsWorldType>(btDynamicsWorldType const & x) {
	return Rice::Data_Object<btDynamicsWorldType>((btDynamicsWorldType *)&x, Rice::Data_Type<btDynamicsWorldType>::klass(), 0, 0);
}


//template<>
//Rice::Object to_ruby<btTriangle>(btTriangle const & x) {
//	return Rice::Data_Object<btTriangle>((btTriangle *)&x, Rice::Data_Type<btTriangle>::klass(), 0, 0);
//}

template<>
Rice::Object to_ruby<btTypedConstraintType>(btTypedConstraintType const & x) {
	return Rice::Data_Object<btTypedConstraintType>((btTypedConstraintType *)&x, Rice::Data_Type<btTypedConstraintType>::klass(), 0, 0);
}

template<>
Rice::Object to_ruby<btWheelInfo>(btWheelInfo const & x) {
	return Rice::Data_Object<btWheelInfo>((btWheelInfo *)&x, Rice::Data_Type<btWheelInfo>::klass(), 0, 0);
}

template<>
Rice::Object to_ruby<btVector4>(btVector4 const & x) {
	return Rice::Data_Object<btVector4>((btVector4 *)&x, Rice::Data_Type<btVector4>::klass(), 0, 0);
}

template<>
Rice::Object to_ruby<btContactSolverInfo>(btContactSolverInfo const & x) {
	return Rice::Data_Object<btContactSolverInfo>((btContactSolverInfo *)&x, Rice::Data_Type<btContactSolverInfo>::klass(), 0, 0);
}

template<>
float const from_ruby<float const>(Rice::Object x) {
  return float(NUM2DBL(x)); 
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

