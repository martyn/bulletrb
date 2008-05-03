# Set the SHATTERED_ROOT to the project directory
SHATTERED_ROOT = File.expand_path(File.dirname(__FILE__))
  
# Require shattered if it is in the vendor directory, otherwise use a gem
begin
  require File.expand_path(File.join(File.dirname(__FILE__),'vendor','shattered','lib','shattered'))
rescue LoadError
  require 'rubygems'
  require 'shattered'
end

%w( bullet ogrerb_debug_draw ).each do |file|
  require File.join(File.dirname(__FILE__), '..', 'lib', file)
end
%w( crosshair ).each do |file|
  require File.join(File.dirname(__FILE__), 'lib', file)
end

class DemoApplication < Shattered::Game
  STEPSIZE = 5
  def initialize
    super
    create_scene_manager(:general)
    create_camera("main", :position => v(20,20,20))
    @camera.look_at(v(1,5,-8))
    create_viewport(:color => rgb(0.2,0,0))
    load_resources("media")
    controls("demo_application").on
    @idle = false
    Crosshair.new()
    @shoot_box_initial_speed = 100.0
  #DemoApplication::DemoApplication()
  #		//see btIDebugDraw.h for modes
  #:
  #m_dynamicsWorld(0),
  #m_pickConstraint(0),
  #m_shootBoxShape(0),
  #	m_cameraDistance(15.0),
  #	m_debugMode(0),
  #	m_ele(20.f),
  #	m_azi(0.f),
  #	m_cameraPosition(0.f,0.f,0.f),
  #	m_cameraTargetPosition(0.f,0.f,0.f),
  #	m_scaleBottom(0.5f),
  #	m_scaleFactor(2.f),
  #	m_cameraUp(0,1,0),
  #	m_forwardAxis(2),	
  #	m_glutScreenWidth(0),
  #	m_glutScreenHeight(0),
  #	m_ShootBoxInitialSpeed(40.f),
  #	m_stepping(true),
  #	m_singleStep(false),
  #	m_idle(false)
  #{
  ##ifndef BT_NO_PROFILE
  #	m_profileIterator = CProfileManager::Get_Iterator();
  ##endif //BT_NO_PROFILE
  #}
  end


#DemoApplication::~DemoApplication()
#{
##ifndef BT_NO_PROFILE
#	CProfileManager::Release_Iterator(m_profileIterator);
##endif //BT_NO_PROFILE
#}

  def myinit
  #    GLfloat light_ambient[] = { 0.2, 0.2, 0.2, 1.0 };
  #    GLfloat light_diffuse[] = { 1.0, 1.0, 1.0, 1.0 };
  #    GLfloat light_specular[] = { 1.0, 1.0, 1.0, 1.0 };
  #    /*	light_position is NOT default value	*/
  #    GLfloat light_position0[] = { 1.0, 10.0, 1.0, 0.0 };
  #    GLfloat light_position1[] = { -1.0, -10.0, -1.0, 0.0 };
  #  
  #    glLightfv(GL_LIGHT0, GL_AMBIENT, light_ambient);
  #    glLightfv(GL_LIGHT0, GL_DIFFUSE, light_diffuse);
  #    glLightfv(GL_LIGHT0, GL_SPECULAR, light_specular);
  #    glLightfv(GL_LIGHT0, GL_POSITION, light_position0);
  #  
  #    glLightfv(GL_LIGHT1, GL_AMBIENT, light_ambient);
  #    glLightfv(GL_LIGHT1, GL_DIFFUSE, light_diffuse);
  #    glLightfv(GL_LIGHT1, GL_SPECULAR, light_specular);
  #    glLightfv(GL_LIGHT1, GL_POSITION, light_position1);

  #    glEnable(GL_LIGHTING);
  #    glEnable(GL_LIGHT0);
  #    glEnable(GL_LIGHT1);
  # 

  #    glShadeModel(GL_SMOOTH);
  #    glEnable(GL_DEPTH_TEST);
  #    glDepthFunc(GL_LESS);

  #		glClearColor(0.7,0.7,0.7,0);

  #    //  glEnable(GL_CULL_FACE);
  #    //  glCullFace(GL_BACK);
  end


  def toggleIdle
    @idle = !@idle
  end


 
  def move(direction)
    @speed = 30
    @camera.move_relative(time_elapsed * @speed * direction)
  end
  
  def look
    @camera.yaw(Ogre::Radian.new(-@mouse.x*0.01))
    @camera.pitch(Ogre::Radian.new(-@mouse.y*0.01))
  end
  
  
  def updateCamera
  #void DemoApplication::updateCamera() {

  #	
  #	glMatrixMode(GL_PROJECTION);
  #	glLoadIdentity();
  #	float rele = m_ele * 0.01745329251994329547;// rads per deg
  #	float razi = m_azi * 0.01745329251994329547;// rads per deg
  #	

  #	btQuaternion rot(m_cameraUp,razi);


  #	btVector3 eyePos(0,0,0);
  #	eyePos[m_forwardAxis] = -m_cameraDistance;

  #	btVector3 forward(eyePos[0],eyePos[1],eyePos[2]);
  #	if (forward.length2() < SIMD_EPSILON)
  #	{
  #		forward.setValue(1.f,0.f,0.f);
  #	}
  #	btVector3 right = m_cameraUp.cross(forward);
  #	btQuaternion roll(right,-rele);

  #	eyePos = btMatrix3x3(rot) * btMatrix3x3(roll) * eyePos;

  #	m_cameraPosition[0] = eyePos.getX();
  #	m_cameraPosition[1] = eyePos.getY();
  #	m_cameraPosition[2] = eyePos.getZ();
  # 
  #    glFrustum(-1.0, 1.0, -1.0, 1.0, 1.0, 10000.0);
  #    glMatrixMode(GL_MODELVIEW);
  #	glLoadIdentity();
  #	gluLookAt(m_cameraPosition[0], m_cameraPosition[1], m_cameraPosition[2], 
  #              m_cameraTargetPosition[0], m_cameraTargetPosition[1], m_cameraTargetPosition[2], 
  #			  m_cameraUp.getX(),m_cameraUp.getY(),m_cameraUp.getZ());
  #}
  end


  def keyboardCallback(key, x, y)
  #void DemoApplication::keyboardCallback(unsigned char key, int x, int y)
  #{
  #	(void)x;
  #	(void)y;

  #		m_lastKey = 0;

  ##ifndef BT_NO_PROFILE
  #        if (key >= 0x31 && key < 0x37)
  #        {
  #                int child = key-0x31;
  #                m_profileIterator->Enter_Child(child);
  #        }
  #        if (key==0x30)
  #        {
  #                m_profileIterator->Enter_Parent();
  #        }
  ##endif //BT_NO_PROFILE

  #    switch (key) 
  #    {
  #    case 'q' : 
  ##ifdef BT_USE_FREEGLUT
  #		//return from glutMainLoop(), detect memory leaks etc.
  #		glutLeaveMainLoop();
  ##else
  #		exit(0);
  ##endif
  #		break;

  #    case 'l' : stepLeft(); break;
  #    case 'r' : stepRight(); break;
  #    case 'f' : stepFront(); break;
  #    case 'b' : stepBack(); break;
  #    case 'z' : zoomIn(); break;
  #    case 'x' : zoomOut(); break;
  #    case 'i' : toggleIdle(); break;
  #	case 'h':
  #			if (m_debugMode & btIDebugDraw::DBG_NoHelpText)
  #				m_debugMode = m_debugMode & (~btIDebugDraw::DBG_NoHelpText);
  #			else
  #				m_debugMode |= btIDebugDraw::DBG_NoHelpText;
  #			break;

  #	case 'w':
  #			if (m_debugMode & btIDebugDraw::DBG_DrawWireframe)
  #				m_debugMode = m_debugMode & (~btIDebugDraw::DBG_DrawWireframe);
  #			else
  #				m_debugMode |= btIDebugDraw::DBG_DrawWireframe;
  #		   break;

  #   case 'p':
  #	   if (m_debugMode & btIDebugDraw::DBG_ProfileTimings)
  #		m_debugMode = m_debugMode & (~btIDebugDraw::DBG_ProfileTimings);
  #	else
  #		m_debugMode |= btIDebugDraw::DBG_ProfileTimings;
  #   break;

  #   case 'm':
  #	   if (m_debugMode & btIDebugDraw::DBG_EnableSatComparison)
  #		m_debugMode = m_debugMode & (~btIDebugDraw::DBG_EnableSatComparison);
  #	else
  #		m_debugMode |= btIDebugDraw::DBG_EnableSatComparison;
  #   break;

  #   case 'n':
  #	   if (m_debugMode & btIDebugDraw::DBG_DisableBulletLCP)
  #		m_debugMode = m_debugMode & (~btIDebugDraw::DBG_DisableBulletLCP);
  #	else
  #		m_debugMode |= btIDebugDraw::DBG_DisableBulletLCP;
  #   break;

  #	case 't' : 
  #			if (m_debugMode & btIDebugDraw::DBG_DrawText)
  #				m_debugMode = m_debugMode & (~btIDebugDraw::DBG_DrawText);
  #			else
  #				m_debugMode |= btIDebugDraw::DBG_DrawText;
  #		   break;
  #	case 'y':		
  #			if (m_debugMode & btIDebugDraw::DBG_DrawFeaturesText)
  #				m_debugMode = m_debugMode & (~btIDebugDraw::DBG_DrawFeaturesText);
  #			else
  #				m_debugMode |= btIDebugDraw::DBG_DrawFeaturesText;
  #		break;
  #	case 'a':	
  #		if (m_debugMode & btIDebugDraw::DBG_DrawAabb)
  #				m_debugMode = m_debugMode & (~btIDebugDraw::DBG_DrawAabb);
  #			else
  #				m_debugMode |= btIDebugDraw::DBG_DrawAabb;
  #			break;
  #		case 'c' : 
  #			if (m_debugMode & btIDebugDraw::DBG_DrawContactPoints)
  #				m_debugMode = m_debugMode & (~btIDebugDraw::DBG_DrawContactPoints);
  #			else
  #				m_debugMode |= btIDebugDraw::DBG_DrawContactPoints;
  #			break;

  #		case 'd' : 
  #			if (m_debugMode & btIDebugDraw::DBG_NoDeactivation)
  #				m_debugMode = m_debugMode & (~btIDebugDraw::DBG_NoDeactivation);
  #			else
  #				m_debugMode |= btIDebugDraw::DBG_NoDeactivation;
  #			if (m_debugMode & btIDebugDraw::DBG_NoDeactivation)
  #			{
  #				gDisableDeactivation = true;
  #			} else
  #			{
  #				gDisableDeactivation = false;
  #			}
  #			break;
  #			

  #		

  #	case 'o' :
  #		{
  #			m_stepping = !m_stepping;
  #			break;
  #		}
  #	case 's' : clientMoveAndDisplay(); break;
  #//    case ' ' : newRandom(); break;
  #	case ' ':
  #		clientResetScene();
  #			break;
  #	case '1':
  #		{
  #			if (m_debugMode & btIDebugDraw::DBG_EnableCCD)
  #				m_debugMode = m_debugMode & (~btIDebugDraw::DBG_EnableCCD);
  #			else
  #				m_debugMode |= btIDebugDraw::DBG_EnableCCD;
  #			break;
  #		}

  #		case '.':
  #		{
  #			shootBox(getCameraTargetPosition());
  #			break;
  #		}

  #		case '+':
  #		{
  #			m_ShootBoxInitialSpeed += 10.f;
  #			break;
  #		}
  #		case '-':
  #		{
  #			m_ShootBoxInitialSpeed -= 10.f;
  #			break;
  #		}

  #    default:
  #//        std::cout << "unused key : " << key << std::endl;
  #        break;
  #    }

  #	if (getDynamicsWorld() && getDynamicsWorld()->getDebugDrawer())
  #		getDynamicsWorld()->getDebugDrawer()->setDebugMode(m_debugMode);

  #	glutPostRedisplay();

  #}
  end

  def wtf?
  #void DemoApplication::specialKeyboard(int key, int x, int y)	
  #{
  #	(void)x;
  #	(void)y;

  #    switch (key) 
  #    {
  #	case GLUT_KEY_F1:
  #		{

  #			break;
  #		}

  #	case GLUT_KEY_F2:
  #	{

  #		break;
  #	}


  #	case GLUT_KEY_END:
  #		{
  #			int numObj = getDynamicsWorld()->getNumCollisionObjects();
  #			if (numObj)
  #			{
  #				btCollisionObject* obj = getDynamicsWorld()->getCollisionObjectArray()[numObj-1];
  #				
  #				getDynamicsWorld()->removeCollisionObject(obj);
  #				btRigidBody* body = btRigidBody::upcast(obj);
  #				if (body && body->getMotionState())
  #				{
  #					delete body->getMotionState();					
  #				}
  #				delete obj;
  #				

  #			}
  #			break;
  #		}
  #    case GLUT_KEY_LEFT : stepLeft(); break;
  #    case GLUT_KEY_RIGHT : stepRight(); break;
  #    case GLUT_KEY_UP : stepFront(); break;
  #    case GLUT_KEY_DOWN : stepBack(); break;
  #    case GLUT_KEY_PAGE_UP : zoomIn(); break;
  #    case GLUT_KEY_PAGE_DOWN : zoomOut(); break;
  #    case GLUT_KEY_HOME : toggleIdle(); break;
  #    default:
  #//        std::cout << "unused (special) key : " << key << std::endl;
  #        break;
  #    }

  #	glutPostRedisplay();

  #}
  end


  def moveAndDisplay
  #void DemoApplication::moveAndDisplay()
  #{
  #	if (!m_idle)
  #		clientMoveAndDisplay();
  #}
  end

  #void	DemoApplication::shootBox(const btVector3& destination)
  def shootBox(destination)
    mass = 10
    startTransform = Transform.new
    startTransform.set_identity
    camPos = @camera.position
  	startTransform.set_origin(camPos.to_bullet)

    @shoot_box_shape ||= BoxShape.new(Vector3.new(1,1,1))
  	@shots ||= []
  	body = localCreateRigidBody(mass, startTransform, @shoot_box_shape)
    @shots << body

    linVel = destination.normalize
    linVel*=@shoot_box_initial_speed
    linVel = linVel.to_bullet
    log.info("creating box with linear velocity #{linVel} from destination #{destination} and position #{camPos}")

#    body.get_world_transform.set_origin(camPos.to_bullet)
# TODO:    body.get_world_transform.set_rotation(Quaternion.new(0,0,0,1))
    body.set_linear_velocity(linVel)
    body.set_angular_velocity(Vector3.new(10,0,0))
    body.show_debug(scene_manager, "shot[#{@shots.length}]", @shoot_box_shape)
    @dynamicsWorld.add_rigid_body(body)
    @collision_objects << body
  end

  #int gPickingConstraintId = 0;
  #btVector3 gOldPickingPos;
  #float gOldPickingDist  = 0.f;
  #btRigidBody* pickedBody = 0;//for deactivation state


  #btVector3	DemoApplication::getRayTo(int x,int y)
  def rayToCenter
    return (@camera.position + @camera.get_forward*far_plane).to_bullet
  end

  def impulse
    rayCallback = ClosestRayResultCallback.new(@camera.position.to_bullet,rayToCenter)
    @dynamicsWorld.rayTest(@camera.position.to_bullet,rayToCenter,rayCallback);
    if (rayCallback.has_hit)
      body = rayCallback.m_collisionObject
      # body.set_activation_state(ACTIVE_TAG);
      impulse = rayToCenter
      impulse.normalize
      impulseStrength = 10.0
      impulse *= impulseStrength;
      relPos = Vector3.new(rayCallback.m_hitPointWorld - body.get_center_of_mass_position())
      body.apply_impulse(impulse,relPos);
    end
  #	case 0:
  #		{
  #			if (state==0)
  #			{
  #		

  #				//add a point to point constraint for picking
  #				if (m_dynamicsWorld)
  #				{
  #					btCollisionWorld::ClosestRayResultCallback rayCallback(m_cameraPosition,rayTo);
  #					m_dynamicsWorld->rayTest(m_cameraPosition,rayTo,rayCallback);
  #					if (rayCallback.HasHit())
  #					{
  #						
  #						
  #						btRigidBody* body = btRigidBody::upcast(rayCallback.m_collisionObject);
  #						if (body)
  #						{
  #							//other exclusions?
  #							if (!(body->isStaticObject() || body->isKinematicObject()))
  #							{
  #								pickedBody = body;
  #								pickedBody->setActivationState(DISABLE_DEACTIVATION);

  #								
  #								btVector3 pickPos = rayCallback.m_hitPointWorld;

  #								btVector3 localPivot = body->getCenterOfMassTransform().inverse() * pickPos;

  #								btPoint2PointConstraint* p2p = new btPoint2PointConstraint(*body,localPivot);
  #								m_dynamicsWorld->addConstraint(p2p);
  #								m_pickConstraint = p2p;
  #								
  #								//save mouse position for dragging
  #								gOldPickingPos = rayTo;

  #								btVector3 eyePos(m_cameraPosition[0],m_cameraPosition[1],m_cameraPosition[2]);

  #								gOldPickingDist  = (pickPos-eyePos).length();

  #								//very weak constraint for picking
  #								p2p->m_setting.m_tau = 0.1f;
  #							}
  #						}
  #					}
  #				}

  #			} else
  #			{

  #				if (m_pickConstraint && m_dynamicsWorld)
  #				{
  #					m_dynamicsWorld->removeConstraint(m_pickConstraint);
  #					delete m_pickConstraint;
  #					//printf("removed constraint %i",gPickingConstraintId);
  #					m_pickConstraint = 0;
  #					pickedBody->forceActivationState(ACTIVE_TAG);
  #					pickedBody->setDeactivationTime( 0.f );
  #					pickedBody = 0;
  #				}

  #				
  #			}

  #			break;

  #		}
  #	default:
  #		{
  #		}
  #	}

  #}
  end

  def mouseMotionFunc
  #void	DemoApplication::mouseMotionFunc(int x,int y)
  #{

  #	if (m_pickConstraint)
  #	{
  #		//move the constraint pivot
  #		btPoint2PointConstraint* p2p = static_cast<btPoint2PointConstraint*>(m_pickConstraint);
  #		if (p2p)
  #		{
  #			//keep it at the same picking distance

  #			btVector3 newRayTo = getRayTo(x,y);
  #			btVector3 eyePos(m_cameraPosition[0],m_cameraPosition[1],m_cameraPosition[2]);
  #			btVector3 dir = newRayTo-eyePos;
  #			dir.normalize();
  #			dir *= gOldPickingDist;

  #			btVector3 newPos = eyePos + dir;
  #			p2p->setPivotB(newPos);
  #		}

  #	}

  #	
  #}
  end

  #btRigidBody*	DemoApplication::localCreateRigidBody(float mass, const btTransform& startTransform,btCollisionShape* shape)
  def localCreateRigidBody(mass, startTransform, shape)

    localInertia = Vector3.new(0,0,0)
    shape.calculate_local_inertia(mass,localInertia)
    #	using motionstate is recommended, it provides interpolation capabilities, and only synchronizes 'active' objects
    myMotionState = DefaultMotionState.new(startTransform, Transform.get_identity)
    @motion_states ||= []
    @motion_states << myMotionState

    cInfo = RigidBodyConstructionInfo.new(mass,myMotionState,shape,localInertia);
    @cInfos ||= []
    @cInfos << cInfo
    
    body = RigidBody.new(cInfo)

    return body
  end

  def setOrthographicProjection
  #//See http://www.lighthouse3d.com/opengl/glut/index.php?bmpfontortho
  #void DemoApplication::setOrthographicProjection() 
  #{

  #	// switch to projection mode
  #	glMatrixMode(GL_PROJECTION);

  #	// save previous matrix which contains the 
  #	//settings for the perspective projection
  #	glPushMatrix();
  #	// reset matrix
  #	glLoadIdentity();
  #	// set a 2D orthographic projection
  #	gluOrtho2D(0, m_glutScreenWidth, 0, m_glutScreenHeight);
  #	glMatrixMode(GL_MODELVIEW);
  #	glLoadIdentity();

  #	// invert the y axis, down is positive
  #	glScalef(1, -1, 1);
  #	// mover the origin from the bottom left corner
  #	// to the upper left corner
  #	glTranslatef(0, -m_glutScreenHeight, 0);

  #}
  end

  #extern CProfileIterator * m_profileIterator;

  def clientResetScene
  #void	DemoApplication::clientResetScene()
  #{
  ##ifdef SHOW_NUM_DEEP_PENETRATIONS
  #	gNumDeepPenetrationChecks = 0;
  #	gNumGjkChecks = 0;
  ##endif //SHOW_NUM_DEEP_PENETRATIONS

  #	int numObjects = 0;
  #	if (m_dynamicsWorld)
  #	{
  #		m_dynamicsWorld->stepSimulation(1.f/60.f,0);
  #		numObjects = m_dynamicsWorld->getNumCollisionObjects();
  #	}
  #	
  #	for (int i=0;i<numObjects;i++)
  #	{
  #		btCollisionObject* colObj = m_dynamicsWorld->getCollisionObjectArray()[i];
  #		btRigidBody* body = btRigidBody::upcast(colObj);
  #		if (body)
  #		{
  #			if (body->getMotionState())
  #			{
  #				btDefaultMotionState* myMotionState = (btDefaultMotionState*)body->getMotionState();
  #				myMotionState->m_graphicsWorldTrans = myMotionState->m_startWorldTrans;
  #				colObj->setWorldTransform( myMotionState->m_graphicsWorldTrans );
  #				colObj->setInterpolationWorldTransform( myMotionState->m_startWorldTrans );
  #				colObj->activate();
  #			}
  #			//removed cached contact points
  #			m_dynamicsWorld->getBroadphase()->getOverlappingPairCache()->cleanProxyFromPairs(colObj->getBroadphaseHandle(),getDynamicsWorld()->getDispatcher());

  #			btRigidBody* body = btRigidBody::upcast(colObj);
  #			if (body && !body->isStaticObject())
  #			{
  #				btRigidBody::upcast(colObj)->setLinearVelocity(btVector3(0,0,0));
  #				btRigidBody::upcast(colObj)->setAngularVelocity(btVector3(0,0,0));
  #			}
  #		}

  #	/*
  #	//quickly search some issue at a certain simulation frame, pressing space to reset
  #		int fixed=18;
  #		for (int i=0;i<fixed;i++)
  #		{
  #			getDynamicsWorld()->stepSimulation(1./60.f,1);
  #		}
  #	*/
  #	}
  #}
  end
end
