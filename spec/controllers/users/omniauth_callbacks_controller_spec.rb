require 'rails_helper'
require 'factory_bot'
require 'spec_helper'

RSpec.describe Users::OmniauthCallbacksController  do 

    before(:each) do
        @persisted_user = FactoryBot.create(:user)
        @new_user = FactoryBot.create(:user, email: "email@email.com")

        # @new_user = mock_model(:user, name: "test", email: "email@email.com",password: "Password123")
        end
    describe "Check facebook" do
        it "User persisted should redirect without saving" do
            allow(User).to receive(:from_omniauth).and_return(@new_user)
            allow(@new_user).to receive(:persisted?).and_return(true)
            expect{controller.facebook}.to raise_error() 
            expect(@new_user).not_to receive(:save)
        end
        it "User not persisted should redirect with saving" do
            allow(User).to receive(:from_omniauth).and_return(@new_user)
            allow(@new_user).to receive(:persisted?).and_return(false)
            expect(@new_user).to receive(:save)
            expect{controller.facebook}.to raise_error() 
        end
    end

    describe "Check google" do
        it "User persisted should redirect without saving" do
            allow(User).to receive(:from_omniauth).and_return(@new_user)
            allow(@new_user).to receive(:persisted?).and_return(true)
            expect{controller.google_oauth2}.to raise_error() 
            expect(@new_user).not_to receive(:save)
        end
        it "User not persisted should redirect with saving" do
            allow(User).to receive(:from_omniauth).and_return(@new_user)
            allow(@new_user).to receive(:persisted?).and_return(false)
            expect(@new_user).to receive(:save)
            expect{controller.google_oauth2}.to raise_error() 
        end
    end

    describe "Failure" do
        it "Should exist for devise to use" do
            expect(controller).to respond_to(:failure)
        end
    end
end


