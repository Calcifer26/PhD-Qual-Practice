require 'rails_helper'

RSpec.describe User, type: :model do

  describe "Check omniauth" do
    before(:each) do
      @token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRlc3RAdGVzdGluZy5jb20iLCJuYW1lIjoidGVzdCIsImlhdCI6MTUxNjIzOTAyMn0.RE4S4M546TUJb2MrV8bNUHtockvoVb0AXvCAXPsOXfI"
    end
    it "check omni auth if use don't exist" do
      adder = OmniAuth.config.add_mock(:twitter, {:uid => '12345', info: {email: "tester@testing.com"}})
      expect(User).to receive(:new).and_return(User.new)
      user = User.from_omniauth(adder)
      expect(user.email).to eq("tester@testing.com")
    end
    it "check omni auth if use don't exist" do
      user = FactoryBot.create(:user, email: "tester@testing.com")
      adder = OmniAuth.config.add_mock(:twitter, {:uid => '12345', info: {email: "tester@testing.com"}})
      expect(User).not_to receive(:new)
      user = User.from_omniauth(adder)
      expect(user.email).to eq("tester@testing.com")
    end
  end

  
end
