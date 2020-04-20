require 'rails_helper'
require 'factory_bot'

RSpec.configure do |config|
    config.include SessionsHelper
end

RSpec.describe QuestionsController, type: :controller do

    #For index
    describe 'get all questions' do
        let!(:question1) { FactoryBot.create(:question_bank, question: 'Test Question1', category: 'cat1', option1: '1', option2: '2', option3: '3', option4: '4', option5: '5', answer: '2')}
        let!(:question2) { FactoryBot.create(:question_bank, question: 'Test Question1', category: 'cat1', option1: '1', option2: '2', option3: '3', option4: '4', option5: '5', answer: '3')}
        let!(:user1) { FactoryBot.create(:user, name: 'Vineet', email: 'admin@cs.tamu.edu', password: 'foobar')}
        fit 'should retrieve all questions' do
           allow(controller).to receive(:current_user).and_return(user1)
           allow(QuestionBank).to receive(:where).with(:creator => user1.email).and_return([question1, question2])
           log_in user1
           get :index
           expect(assigns(:user_questions)).to include(question1,question2)
        end
    end
    
    #For create
    fdescribe 'Create Question' do
        it 'should fail to add and redirect to login' do
            allow(controller).to receive(:logged_in?).and_return(false)
            post :create, question: {question: 'Test', category: 'RSpec Test', option1: '1', option2: '2', option3: '3', option4: '4', option5: '5', answer: '2'}
            expect(flash[:danger]).to match(/Please log in/)
            expect(response).to redirect_to(login_url)
        end
        
        let!(:user1) { FactoryBot.create(:user, name: 'Vineet', email: 'admin@cs.tamu.edu', password: 'foobar')}
        it 'should add a question to the database' do
            log_in user1
            allow(controller).to receive(:current_user).and_return(user1)
            post :create, question: {question: 'Test', category: 'Networks', option1: '1', option2: '2', option3: '3', option4: '4', option5: '5', answer: '2'},\
            imagequestion: 'image/upload/v1525047613/zevehwni8569078s0z77.png#c963266e73e33a30e7f295408b9b1451a70a002f',\
            image1: 'image/upload/v1525047613/zevehwni8569078s0z77.png#c963266e73e33a30e7f295408b9b1451a70a002f',\
            image2: 'image/upload/v1525047613/zevehwni8569078s0z77.png#c963266e73e33a30e7f295408b9b1451a70a002f',\
            image3: 'image/upload/v1525047613/zevehwni8569078s0z77.png#c963266e73e33a30e7f295408b9b1451a70a002f',\
            image4: 'image/upload/v1525047613/zevehwni8569078s0z77.png#c963266e73e33a30e7f295408b9b1451a70a002f',\
            image5: 'image/upload/v1525047613/zevehwni8569078s0z77.png#c963266e73e33a30e7f295408b9b1451a70a002f'
            expect(flash[:success]).to match(/Question was successfully added/)
            expect(response).to redirect_to(admin_questions_path)
        end
        
    end

    # For update
    describe 'Update Question' do
        let!(:user1) { FactoryBot.create(:user, name: 'Vineet', email: 'admin@cs.tamu.edu', password: 'foobar')}
        
        let!(:question1) { FactoryBot.create(:question_bank, question: 'Test', category: 'Networks', option1: '1', option2: '2', option3: '3', option4: '4', option5: '5', answer: '2')}
        it 'should update the attributes' do
            put :update, id: question1.id, question: {question: 'Test', category: 'Networks', option1: 'one', option2: 'two', option3: 'three', option4: 'four', option5: 'five', answer: 'two'},\
            imagequestion: 'image/upload/v1525047613/zevehwni8569078s0z77.png#c963266e73e33a30e7f295408b9b1451a70a002f',\
            image1: 'image/upload/v1525047613/zevehwni8569078s0z77.png#c963266e73e33a30e7f295408b9b1451a70a002f',\
            image2: 'image/upload/v1525047613/zevehwni8569078s0z77.png#c963266e73e33a30e7f295408b9b1451a70a002f',\
            image3: 'image/upload/v1525047613/zevehwni8569078s0z77.png#c963266e73e33a30e7f295408b9b1451a70a002f',\
            image4: 'image/upload/v1525047613/zevehwni8569078s0z77.png#c963266e73e33a30e7f295408b9b1451a70a002f',\
            image5: 'image/upload/v1525047613/zevehwni8569078s0z77.png#c963266e73e33a30e7f295408b9b1451a70a002f'
            expect(flash[:success]).to match(/was successfully updated/)
            expect(response).to redirect_to(questions_path(question1.id))
        end
    end
    
    
    #For destroy
    describe 'Destory Question' do
        let!(:question1) { FactoryBot.create(:question_bank, question: 'Test Question',category: 'RSpec Test',option1: '1', option2: '2', option3: '3', option4: '4', option5: '5', answer: '2')}
        it 'should delete the question' do
            delete :destroy, {id: question1.id}
            expect(flash[:destroy]).to match(/deleted/)
            expect(response).to redirect_to(questions_path)
        end
    end
    
    #For edit
    describe 'Edit Question' do
        let!(:question1) { FactoryBot.create(:question_bank, question: 'Test Question',category: 'RSpec Test',option1: '1', option2: '2', option3: '3', option4: '4', option5: '5', answer: '2')}
        let!(:question2) { FactoryBot.create(:question_bank, question: 'Test Question',category: 'RSpec Test',option1: '1', option2: '2', option3: '3', option4: '4', option5: '5', answer: '3')}
        it 'should display the questions' do
            get :edit, {id: question1.id}
            expect(assigns(:question).id).to equal(question1.id)
            expect(assigns(:question).id).not_to equal(question2.id)
        end
    end
    
end
