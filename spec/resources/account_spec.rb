require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AWeber::Resources::Account do
  include BaseObjects
  let(:account) { aweber.account }
  subject { account }
  
  its(:path) { should == "/accounts/1" }
  
  it { should respond_to :id }
  it { should respond_to :http_etag }
  it { should respond_to :self_link }
  it { should respond_to :resource_type_link }
  it { should respond_to :lists_collection_link }
  it { should respond_to :integrations_collection_link }
  it { should respond_to :find_subscribers }
  it { should respond_to :web_forms }

  it "should find subscribers" do
    subscribers = account.find_subscribers(:email => 'joe@example.com')
    subscribers.should_not be_false
    subscribers.should be_an AWeber::Collection
    subscribers.size.should == 1
    subscribers.first[1].self_link.should == 'https://api.aweber.com/1.0/accounts/1/lists/303449/subscribers/1'
  end

  describe "When Getting Web Forms" do
    let(:webforms) { account.web_forms }
    subject { webforms }

    it { should be_an Array }
    its(:size) { should == 181 }
    
    it "should be a list of Web Forms" do
      webforms[0].should be_an AWeber::Resources::WebForm
    end

    it "should have correct url" do
      webforms.each do |webform|
        webform.uri.should =~ %r[/accounts/1/lists/\d*/web_forms/\d*]
      end
    end
  end

  describe "when getting web form split tests" do
    let(:split_tests) { account.web_form_split_tests }
    subject { split_tests }

    it { should be_an Array }
    its(:size) { should == 10 }
    
    it "should be a list of Web Forms" do
      split_tests[0].should be_an AWeber::Resources::WebFormSplitTest
    end

    it "should have correct url" do
      split_tests.each do |split_test|
        split_test.uri.should =~ %r[/accounts/1/lists/\d*/web_form_split_tests/\d*]
      end
    end
  end
end
