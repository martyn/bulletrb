
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
float const& from_ruby<float const&>(Rice::Object x) {
  return *(new float(NUM2DBL(x))); //TODO: Memory leak
}

template<>
Rice::Object to_ruby<btDispatcherInfo>(btDispatcherInfo const & x) {
  return Rice::Data_Object<btDispatcherInfo>((btDispatcherInfo *)&x, Rice::Data_Type<btDispatcherInfo>::klass(), 0, 0);
}

template<>
Rice::Object to_ruby<btContactSolverInfo>(btContactSolverInfo const & x) {
	return Rice::Data_Object<btContactSolverInfo>((btContactSolverInfo *)&x, Rice::Data_Type<btContactSolverInfo>::klass(), 0, 0);
}

template<>
Rice::Object to_ruby<btUnionFind>(btUnionFind const & x) {
	return Rice::Data_Object<btUnionFind>((btUnionFind *)&x, Rice::Data_Type<btUnionFind>::klass(), 0, 0);
}

template<>
Rice::Object to_ruby<unsigned short>(const unsigned short& x) {
  return UINT2NUM(x);
}

template<>
unsigned short from_ruby<unsigned short>(Rice::Object x) {
  return NUM2UINT(x);
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

template<> 
btStackAlloc* from_ruby<btStackAlloc*>(Rice::Object x) {
  if(x == Rice::Nil)
    return 0;
  
  if(std::string("Bullet::StackAlloc") == x.class_of().name().c_str())
    return (btStackAlloc*)&x;

  std::string s("Unable to convert ");
  s += x.class_of().name().c_str();
  s += " to ";
  s += "btStackAlloc*";
  throw std::invalid_argument(s.c_str());
}

template<> 
btPoolAllocator* from_ruby<btPoolAllocator*>(Rice::Object x) {
  if(x == Rice::Nil)
    return 0;
  
  if(std::string("Bullet::PoolAllocator") == x.class_of().name().c_str())
    return (btPoolAllocator*)&x;

  std::string s("Unable to convert ");
  s += x.class_of().name().c_str();
  s += " to ";
  s += "btPoolAllocator*";
  throw std::invalid_argument(s.c_str());
}

btTransform Transform_GetIdentity() {
  	btTransform *tr = new btTransform();
		tr->setIdentity();
		return *tr; //TODO Memory Leak?
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

