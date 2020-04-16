require 'rails_helper'
require 'factory_bot'

RSpec.describe CategoriesController, type: :controller do
    before(:each) do
        @all_categories = [
            FactoryBot.create(:category_bank, id: 1),
            FactoryBot.create(:category_bank)
        ]
        @all_user = [
            FactoryBot.create(:user),
            FactoryBot.create(:user, email: "test2@gmail.com")
        ]
        # allow(controller).to receive(:current_user).and_return(@all_user[0])
        
    end

    describe "login required to edit" do
        it "to access you need login" do
            # allow(controller).to receive(:current_user).and_return(nil)    
            post :create
            expect(response).to redirect_to(login_path)
        end
    end
    describe "index" do 
        it "index return result" do
            # allow(CategoryBank).to receive(:all).and_return(@all_categories)
            get :index
            expect(response.status).to equal 200
        end
    end

    describe "create" do
        it "should work with valid parameter" do
            allow(controller).to receive(:current_user).and_return(@all_user[0])
            post :create, category_banks: {category:  "Cat1"}
            expect(response).to redirect_to categories_path
        end
    end

    describe "update category" do
        it "should update the values" do 
            category = @all_categories[0]
            put :update, id:category.id,  category_banks: { category: "Hello"}
            # expect(flash[:success]).to match(/was successfully updated/)
            expect(response).to redirect_to(categories_path([category]))
        end
    end

    describe "destroy category" do
        it "should destroy the category" do 
            category = @all_categories[0]
            delete :destroy, id:category.id
            # expect(flash[:success]).to match(/was successfully updated/)
            expect(response).to redirect_to(categories_path())
        end
    end

    describe "show category" do
        it "should show the category" do 
            category = @all_categories[0]
            get :show, id:category.id
            # expect(flash[:success]).to match(/was successfully updated/)
            expect(response).to redirect_to(categories_path())
        end
    end


    describe "edit category" do
        it "should return the category page" do 
            category = @all_categories[0]
            get :edit, id:category.id
            # expect(flash[:success]).to match(/was successfully updated/)
            expect(response.status).to eq(200)
        end
    end




end
