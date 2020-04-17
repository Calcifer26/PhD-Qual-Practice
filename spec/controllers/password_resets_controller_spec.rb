require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do

    before(:each) do
        @user_exist = FactoryBot.create(:user)
        @non_user_email = "non@non.com"
    end

    describe "Create" do

        it "On email doesn't exist should redirct" do
            post :create, password_reset: { email: @non_user_email}
            expect(response).to redirect_to(login_path)
            expect(flash[:notice]).to eq("Email address not found")
        end

        it "On email exist should send password reset email" do
            d = double( deliver: "")
            allow(UserMailer).to receive(:password_reset).and_return( d)
            allow(@user_exist).to receive(:send_password_reset_email).and_return("")
            post :create, password_reset: { email: @user_exist.email}
            expect(response).to redirect_to(login_path)
            expect(flash[:success]).to eq("Email sent with password reset instructions")
        end
    end 

    describe "Edit" do
        it "Dummy" do
        end
    end


    xdescribe "Update" do

        it "On password doesn't exist should redirct" do
            put :update, user: { email: @non_user_email}
            expect(response).to render(:edit)
            expect(flash[:notice]).to eq("Email address not found")
        end

        it "On email exist should send password reset email" do
            d = double( deliver: "")
            allow(UserMailer).to receive(:password_reset).and_return( d)
            allow(@user_exist).to receive(:send_password_reset_email).and_return("")
            post :create, password_reset: { email: @user_exist.email}
            expect(response).to redirect_to(login_path)
            expect(flash[:success]).to eq("Email sent with password reset instructions")
        end
    end  


end