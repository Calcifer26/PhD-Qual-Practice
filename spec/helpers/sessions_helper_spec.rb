require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SessionsHelper. For example:
#
# describe SessionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe SessionsHelper, type: :helper do
  
  class DummyClass 
    include SessionsHelper
    def current_user
      FactoryBot.create(:user, is_admin: true)
    end
  end
  describe "is_admin test" do
    it "curent user should return admin" do
      # admin = FactoryBot.create(:user, is_admin: true)
      expect(DummyClass.new.is_admin?()).to eq(true)
    end
  end

  xdescribe "log_ut" do
    it "logout should " do
      dummy = DummyClass.new
      allow().to receive(:sign_out).and_return(true)
      expect(assigns(:current_user)).to eq(nil)
      dummy.log_out
    end
  end

end
