require 'rails_helper'

RSpec.describe AdminController, type: :controller do
    before(:each) do 
        @admin = FactoryBot.create(:user, is_admin: true, id: 1001)
        @user = FactoryBot.create(:user, email: "user@user.com", id: 10002, reviewStatus: "Pending")
        @question_bank = FactoryBot.create(:question_bank)
        @categories = FactoryBot.create(:category_bank)
    end
    describe "Access control" do
        it "Should redirect to loggin" do
            get :index
            expect(response.status).to eq(302)
        end
    end

    describe "Login required" do
        before(:each) do 
            allow(controller).to receive(:current_user).and_return(@admin)
            # allow(QuestionBank).to receive(:all).and_return([@question_bank])
            # allow(QuestionBank).to receive(:find).and_return(@question_bank)
            # allow(CategoryBank).to receive(:all).and_return([@categories])
        end
        describe "Index" do 
            it "Index works" do 
                get :index 
                expect(response.status).to eq(200)
            end
        end

        describe "Admin Questions" do
            it "Should return all question" do
                get :admin_questions
                expect(response.status).to eq(200)
                allow(@question_bank).to receive(:update).and_return("")
                expect( assigns(:questions)).to eq([@question_bank])
            end
        end

        describe "Admin show" do
            it "Should update the review status adn redirect to admin question" do
                get :show, flag_: "q", id: @question_bank.id
                @question_bank.reviewStatus = "Pending"
                @question_bank.reload
                # expect(response.status).to eq(200)
                expect(response).to redirect_to(admin_questions_path)
                @question_bank.reload
                expect( @question_bank.reviewStatus).to eq("Approved")
            end
            it "Should update the review status of user and redirect to index" do
                get :show, flag_: "u", id: @user.id
                @user.reload
                # expect(response.status).to eq(200)
                # expect(response).to redirect_to(admin_path)
                expect( @user.reviewStatus).to eq("Approved")
            end
        end

        describe "Delete old user" do
            xit "Should call delete_old_user" do 
                expect(response).to have_http_status(:ok)
            end
        end


        describe "Admin categories" do
            xit "Should call return ok" do 
                get :admin_categories
                expect(response).to have_http_status(:ok)
            end
        end

        describe "Admin destory" do
            it "Should delete the question and redirect to admin question" do
                delete :destroy, flag: "q", id: @question_bank.id
                @question_bank.reviewStatus = "Pending"
                # expect(response.status).to eq(200)
                expect(response).to redirect_to(admin_questions_path)
                
                expect{ @question_bank.reload}.to raise_error(ActiveRecord::RecordNotFound)
            end
            it "Should delete the user and redirect to index" do
                delete :destroy, flag: "u", id: @user.id
                expect{ @user.reload}.to raise_error(ActiveRecord::RecordNotFound)
            end

            it "Should not allowed to delete self" do
                delete :destroy, flag: "u", id: @admin.id
                expect{ @admin.reload}.not_to raise_error(ActiveRecord::RecordNotFound)
            end
        end

    end
            



end
