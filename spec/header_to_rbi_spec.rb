require File.dirname(__FILE__) + '/spec_helper.rb'

include CppParser

describe "Parser (Vector3)" do
  setup do
    filepath = File.join(File.dirname(__FILE__), "header_to_rbi", "vector3.h")
    @v3 = Parser.new(filepath)
  end
  
  it "should get classes in vector3" do
    @v3.klasses.keys.sort.should == ["Point2 < Vector2Base", "Point3 < Vector4Base", "Vector2 < Vector2Base", "Vector3 < Vector4Base", "Vector4 < Vector4Base"]
  end
  
  it "should output to rbi" do
    @v3.to_rbi.length.should == 6370
  end
end

describe "Collision" do
  setup do
    filepath = File.join(File.dirname(__FILE__), "header_to_rbi", "collision.h")
    @parsed = Parser.new(filepath)
  end
  
  it "should get classes" do
    @parsed.klasses.keys.sort.should ==  ["CollisionAlgorithm", "CollisionAlgorithmConstructionInfo", "PersistentManifold"]
  end
  
  it "should output to rbi" do
    @parsed.to_rbi.length.should == 719
  end
end


describe "Configuration" do
  setup do
    filepath = File.join(File.dirname(__FILE__), "header_to_rbi", "configuration.h")
    @parsed = Parser.new(filepath)
  end
  
  it "should get classes" do
    @parsed.klasses.keys.sort.should ==  ["DefaultCollisionConfiguration < CollisionConfiguration"] 
  end
  
  it "should output to rbi" do
    @parsed.to_rbi.length.should == 283
  end
end


describe "Method name" do
  it "should parse out 'Vector3 Cross(const Vector3& a, const Vector3& b);'" do
    line = "Vector3 Cross(const Vector3& a, const Vector3& b);"
    method = CppParser::Method.new(line)
    CppParser::Method.scan(line) { @scanned=true }
    @scanned.should == true
    Constructor.valid?(line, "Vector3").should == nil
    method.name.should == "Cross"
    method.arguments.should == "Vector3&, Vector3&"
  end
  it "should parse out empty args" do
    line = "bool IsFinite() const;"
    method = CppParser::Method.new(line)
    CppParser::Method.scan(line) { @scanned=true }
    @scanned.should == true
    method.name.should == "IsFinite"
    method.arguments.should == nil
  end
  
  it "should be ok with spaces in the method name" do
    line = 'virtual void processCollision (CollisionObject* body0,CollisionObject* body1,const DispatcherInfo& dispatchInfo,ManifoldResult* resultOut)'
    CppParser::Method.scan(line) { @scanned=true }
    @scanned.should == true
    method = CppParser::Method.new(line)
    method.name.should == "processCollision"
    method.arguments.should == "CollisionObject*, CollisionObject*, DispatcherInfo&, ManifoldResult*"
  end
  
  it "should not work for defines'" do
    line = 'define BT_CLAMP(number,minval,maxval) (number<minval?minval:(number>maxval?maxval:number))'
    CppParser::Method.scan(line) { @scanned=true }
    @scanned.should == nil
  end
  
  it "should work for 'void bt_edge_plane(const Vector3 & e1,const Vector3 &  e2, const Vector3 & normal,Vector4 & plane)'" do
    line = 'void bt_edge_plane(const Vector3 & e1,const Vector3 &  e2, const Vector3 & normal,Vector4 & plane)'
    CppParser::Method.scan(line) { @scanned=true }
    @scanned.should == true
    
    method = CppParser::Method.new(line)
    method.name.should == "bt_edge_plane"
    method.arguments.should == "Vector3, Vector3, Vector3, Vector4" 
  end
end


describe "Class parsing" do
  it "should parse 'struct CollisionAlgorithmConstructionInfo'" do
    method = 'struct CollisionAlgorithmConstructionInfo'
    method = Klass.new(method)
    method.name.should == "CollisionAlgorithmConstructionInfo"
  end
  it "should parse 'class CollisionAlgorithm'" do
    method = 'class CollisionAlgorithm'
    method = Klass.new(method)
    method.name.should == "CollisionAlgorithm"
  end
  it "should parse '__declspec(align(16)) class Vector3 : public Vector4Base'" do
    method = '__declspec(align(16)) class Vector3 : public Vector4Base'
    method = Klass.new(method)
    method.name.should == "Vector3"
  end
  it "should parse 'class	DefaultCollisionConfiguration : public CollisionConfiguration'" do
    method = 'class	DefaultCollisionConfiguration : public CollisionConfiguration'
    Klass.valid?(method).should == true
    method = Klass.new(method)
    method.name.should == "DefaultCollisionConfiguration"
  end
end
