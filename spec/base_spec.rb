require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe AWeber::Base do
  before :each do
    @oauth  = AWeber::OAuth.new("token", "secret")
    @aweber = AWeber::Base.new(@oauth)
  end
  
  it "should have an account" do
    @aweber.account.should be_an AWeber::Resources::Account
  end
  
  it "should expand uris to full paths" do
    resp = @oauth.get("https://api.aweber.com/1.0/accounts")
    @oauth.should_receive(:get).with("https://api.aweber.com/1.0/accounts").and_return(resp)
    @aweber.account
  end
  
  it "should delegate to the oauth object" do
    @oauth.should_receive(:get).with("https://api.aweber.com/1.0/foo")
    @aweber.send(:get, "/foo")
  end

  it "should set oauth request token" do
    oauth_stub = double('oauth consumer')
    oauth_stub.stub(:consumer) { 'consumer' }
    oauth_stub.stub(:request_token=)
    oauth_stub.stub(:authorize_with_verifier) { 'oauth' }

    rtoken = double('request token')
    rtoken.stub(:params=)

    oauth_stub.should_receive(:request_token=).with(rtoken)
    AWeber::OAuth.stub(:new) { oauth_stub }
    OAuth::RequestToken.stub(:new)     { rtoken }

    aweber = AWeber::Base.authorize_with_authorization_code('a|b|c|d|verifier')
  end

  it "should delegate authorization to oauth object" do
    oauth_stub = double('oauth consumer')
    oauth_stub.stub(:consumer) { 'consumer' }
    oauth_stub.stub(:request_token=)
    oauth_stub.stub(:authorize_with_verifier) { 'oauth' }

    oauth_stub.should_receive(:authorize_with_verifier).with('verifier')
    AWeber::OAuth.stub(:new) { oauth_stub }
    aweber = AWeber::Base.authorize_with_authorization_code('a|b|c|d|verifier')
  end

  it "should return new aweber base instance" do
    oauth_stub = double('oauth consumer')
    oauth_stub.stub(:consumer) { 'consumer' }
    oauth_stub.stub(:request_token=)
    oauth_stub.stub(:authorize_with_verifier) { 'oauth' }

    base_stub = double('aweber base')
    AWeber::Base.stub(:new) { base_stub }

    AWeber::OAuth.stub(:new) { oauth_stub }
    aweber = AWeber::Base.authorize_with_authorization_code('a|b|c|d|verifier')
    aweber.should == base_stub
  end
end
