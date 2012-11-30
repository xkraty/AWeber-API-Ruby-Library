require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "AWeber::Resources::Campaign" do
  include BaseObjects
  subject { aweber.account.lists[1].campaigns[50000047] }
  
  its(:path) { should == "/accounts/1/lists/1/campaigns/50000047" }
  
  it { should respond_to :campaign_type }
  it { should respond_to :click_tracking_enabled }
  it { should respond_to :content_type }
  it { should respond_to :links }
  it { should respond_to :messages }
  it { should respond_to :spam_assassin_score }
  it { should respond_to :stats }
  it { should respond_to :subject }
  it { should respond_to :total_spam_complaints }
  it { should respond_to :total_undelivered }
  it { should respond_to :total_unsubscribes }

  it "should should have a collection of stats" do
    subject.stats.should be_an AWeber::Collection
    subject.stats['total_clicks'].should be_an AWeber::Resources::Stat
  end

end
