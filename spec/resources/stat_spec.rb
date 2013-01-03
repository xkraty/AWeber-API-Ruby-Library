require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AWeber::Resources::Link do
  include BaseObjects
  subject { aweber.account.lists[1].campaigns[50000047].stats['total_clicks'] }
  
  its(:path) { should == "/accounts/1/lists/1/campaigns/50000047/stats/total_clicks" }
  
  it { should respond_to :description }
  it { should respond_to :http_etag }
  it { should respond_to :id }
  it { should respond_to :resource_type_link }
  it { should respond_to :self_link }
  it { should respond_to :value }
end
