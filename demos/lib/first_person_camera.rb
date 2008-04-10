class FirstPersonCamera < Shattered::Actor
	timer :every => :frame, :action => :update_mouse
	  
  def move(direction)
  	@translate_vector += direction.to_v * @move_scale
	end
  
  def pause
  	@mouse.set_buffered true
	end

	def continue
		@mouse.set_buffered false
	end
	
	def initialize(camera)
		@mouse = Shattered::Game.instance.mouse
		self.keymap="fps"
		@camera = camera
	  @translate_vector = v(0,0,0)
		@rot_x = Ogre::Degree.new(0)
		@rot_y = Ogre::Degree.new(0)
	  @move_speed = 100
		@rotate_speed = 36
		@move_scale = 0.0
	  @rot_scale = 0.0
  end
	
	def update_mouse(time_elapsed)
		@mouse.capture

		if !@mouse.buffered
			# If this is the first frame, pick a speed
			if time_elapsed == 0	
				@move_scale = 1
				@rot_scale = 0.1
			else
				# ~100 units / second
				@move_scale = @move_speed * time_elapsed
				# ~10 seconds for full rotation
				@rot_scale = @rotate_speed * time_elapsed
			end

			@rot_x = Ogre::Degree.new 0
			@rot_y = Ogre::Degree.new 0

		end
	
		if !@mouse.buffered
			return false unless process_unbuffered_mouse_input
		end

		if !@mouse.buffered
			move_camera
			@translate_vector = v(0,0,0)
		end
	
	end

	def process_unbuffered_mouse_input
		state = @mouse.mouse_state

		if state.button_down?(OIS::MB_Right)
			@translate_vector.x += state.X.rel * 0.13
			@translate_vector.y -= state.Y.rel * 0.13
		else
			@rot_x = Ogre::Degree.new(-state.X.rel * 0.13)
			@rot_y = Ogre::Degree.new(-state.Y.rel * 0.13)
		end
	end
	
	# Process the movement we've calculated this frame
	def move_camera
		@camera.yaw(@rot_x)
		@camera.pitch(@rot_y)
		@camera.move_relative(@translate_vector)
	end
end
