= bulletrb

http://rubyforge.org/projects/bulletrb/

== DESCRIPTION:

Bulletrb provides a set of ruby interfaces for the bullet physics engine.

== FEATURES/PROBLEMS:

Provides a 1-1 mapping of the bullet physics engine into ruby.
Most classes are imported.

== SYNOPSIS:

dynamicsWorld = DiscreteDynamicsWorld.new(dispatcher,overlappingPairCache,solver,collisionConfiguration)
dynamicsWorld.set_gravity(Vector3.new(0,-10,0))
steps = 99
steps.times do
  dynamicsWorld.step_simulation(1.0/60.0, 10, 1.0/60.0)
end

== REQUIREMENTS:

Linux, Windows, or Mac(x86).   To do anything useful you'll probably also want a 3d accelerated video card.

== INSTALL:

sudo gem install bulletrb
NOTE:  This is once it is released.

== LICENSE:

(The MIT License)

Copyright (c) 2008 FIX

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
