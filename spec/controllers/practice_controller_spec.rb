require 'rails_helper'

RSpec.describe PracticeController, type: :controller do
  
  #index
  describe 'questions for practice' do
    let!(:question1) { FactoryBot.create(:question_bank, question: 'Test Question1', category: 'cat1', option1: '1', option2: '2', option3: '3', option4: '4', option5: '5', answer: '2')}
    let!(:question2) { FactoryBot.create(:question_bank, question: 'Test Question2', category: 'cat2', option1: '1', option2: '2', option3: '3', option4: '4', option5: '5', answer: '3')}
    let(:params) { {categories: {'cat1' => "1"}} }
    it 'get questions of a given category' do
      get :index, categories: {'cat1'=>"1"}
      expect(assigns(:questions)).not_to include(question2)
    end
    it 'if category missing should redirect to category' do
      get :index 
      expect(response).to redirect_to(selcat_path)
    end
  end
  
end
