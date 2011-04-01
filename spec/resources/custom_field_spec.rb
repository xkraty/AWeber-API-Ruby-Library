require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AWeber::Resources::CustomField do
  include BaseObjects
  subject { aweber.account.lists[1].custom_fields[1] }
  
  its(:path) { should == "/accounts/1/lists/1/custom_fields/1" }
  
  it { should respond_to :name }
  it { should respond_to :is_subscriber_updateable }
  it { should respond_to :is_subscriber_updateable? }
end
