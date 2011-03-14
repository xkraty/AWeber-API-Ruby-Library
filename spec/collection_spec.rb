require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe AWeber::Collection do
  before :each do
    @oauth  = AWeber::OAuth.new("token", "secret")
    @aweber = AWeber::Base.new(@oauth)
    data    = JSON.parse(fixture("lists.json"))
    @lists  = AWeber::Collection.new(@aweber, AWeber::Resources::List, data)
  end
  
  it "should create classes from the one passed into initialize" do
    @lists[1].should be_an AWeber::Resources::List
  end
  
  it "should be iterable" do
    @lists.should respond_to :each
    @lists.map { |id, l| id }.should be_an Array
  end
  
  it "should be accessible via id in normal Hash form" do
    @lists[1].id.should == 1
  end
  
  it "should retrieve more resources, if needed, when being iterated over" do
    list_ids = @lists.map{ |id, list| list }
    list_ids.length.should == 3
    list_ids.all? { |e| e.is_a? AWeber::Resources::List }.should == true
  end
  
  it "should return single entries with dynamic find_by methods" do
    @lists.find_by_id(1).should be_an AWeber::Resources::List
    @lists.find_by_id(1).id.should == 1
  end
  
  it "should return Hashes of entries when find_by methods match many" do
    lists = @lists.find_by_resource_type_link("https://api.aweber.com/1.0/#list")
    lists.length.should == 3
  end
  
  it "should not have an empty path" do
    @lists.path.should be_empty
  end
  
  it "should create resource with itself as a parent" do
    collection = AWeber::Collection.new(@aweber, FakeParent)
    @aweber.stub(:get).and_return({ :name => "Bob" })
    collection[1].parent.should == collection
  end
  
  it "should pass path request through its parent" do
    root   = AWeber::Collection.new(@aweber, FakeParent)
    leaf   = AWeber::Resource.new(@aweber, :id => 1, :parent => root)
    branch = AWeber::Collection.new(@aweber, FakeChild, :parent => leaf)
    leafy  = AWeber::Resource.new(@aweber, :id => 2, :parent => branch)
    leafy.path.should == "/parents/1/children/2"
  end
  
  context "when searching" do
    before do
      @root       = AWeber::Collection.new(@aweber, FakeParent)
      @parent     = AWeber::Resource.new(@aweber, :id => 1, :parent => @root)
      @collection = AWeber::Collection.new(@aweber, FakeChild, :parent => @parent)
      path        = "/parents/1/children?ws.op=search&name=default123456"
      @aweber.should_receive(:get).with(path).and_return({})
    end
    
    it "should search the API" do
      @collection.search(:name => "default123456")
    end
    
    it "should return a new collection" do
      @collection.search(:name => "default123456").should be_an AWeber::Collection
    end
    
    it "should return a new collection with the same parent" do
      @collection.search(:name => "default123456").parent.should be @collection.parent
    end
  end
end
