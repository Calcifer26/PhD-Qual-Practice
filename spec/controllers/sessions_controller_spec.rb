require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

 describe "GET #new" do
   it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
   end
 end

 describe "GET #create" do
    before(:each) do
        @user_exist = FactoryBot.create(:user)
        @non_exist_email = "non@gmail.com"
    end
    
    it "On email duplicate redirect" do
        get :create, session: { email: @non_exist_email}
        expect(response).to redirect_to(register_url)
   end

   it "On missing password should redirect login" do
        get :create, session: { email: @user_exist.email}
        expect(flash[:notice]).to eq("Invalid Username or Password")
        expect(response).to redirect_to(login_url)
    end

    it "On all correct should login successfully and redirect" do
        get :create, session: { email: @user_exist.email, password: @user_exist.password}
        expect(flash[:notice]).to eq(nil)
        expect(response).to redirect_to("/")
    end
 end

 describe "GET #destroy" do
    it "returns http success" do
        get :destroy
        expect(response).to redirect_to(login_url)
   end
 end

end
