require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AWeber::Resources::List do
  include BaseObjects
  subject { aweber.account.lists[1] }
  
  its(:path) { should == "/accounts/1/lists/1" }
  
  it { should respond_to :campaigns_collection_link }
  it { should respond_to :http_etag }
  it { should respond_to :id }
  it { should respond_to :name }
  it { should respond_to :unique_list_id }
  it { should respond_to :resource_type_link }
  it { should respond_to :self_link }
  it { should respond_to :subscribers_collection_link }
  it { should respond_to :web_form_split_tests_collection_link }
  it { should respond_to :web_forms_collection_link }
  it { should respond_to :broadcasts }
  it { should respond_to :followups }
  
  it "should should have a collection of broadcasts" do
    subject.broadcasts.should be_an AWeber::Collection
    subject.broadcasts[1].should be_an AWeber::Resources::Campaign
  end
  
  it "should should have a collection of followups" do
    subject.followups.should be_an AWeber::Collection
    subject.followups[1].should be_an AWeber::Resources::Campaign
  end
end
