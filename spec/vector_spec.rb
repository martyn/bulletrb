require File.dirname(__FILE__) + '/spec_helper.rb'

# Time to add your specs!
# http://rspec.rubyforge.org/
describe "BTVector" do

  it "has a valid constructor" do
    vector = Bullet::Vector3.new(0,1,2)
    puts vector.x, vector.y, vector.z
    vector.x.should == 0
    vector.y.should == 1
    vector.z.should == 2
  end

end

