require 'rails_helper'

RSpec.describe QuizController, type: :controller do
    describe 'Index Function' do
        context "Too many characters" do
            let(:params) { {timervalue1: {'timervalue' => '123456'}} }
            let(:params) { {timervalue2: {'timervalue' => 'sw'}} }
            let(:params) { {timervalue3: {'timervalue' => '-1'}} }
            let(:params) { {timervalue4: {'timervalue' => '1445'}} }
                it "returns : Too many characters" do
                    get :index, timervalue: '123456'
                    expect(flash[:notice]).to match("Invalid timer value. Too many characters in timer value.")
            end 
            it "returns : No Alpha or decimal characters" do
                    get :index, timervalue: 'sw'
                    expect(flash[:notice]).to match("Invalid timer value. Please enter a valid numeric value (don't use letters or decimals).")
            end
            it "returns : No non positive value" do
                    get :index, timervalue: '-1'
                    expect(flash[:notice]).to match("Invalid timer value. Please set timer value to be at least 1 minute.")
            end
            it "returns : Should not be too high" do
                    get :index, timervalue: '1445'
                    expect(flash[:notice]).to match("Invalid timer value. Timer value is too high.")
            end
            it "test if parameter is empty" do
                get :index
                expect(flash[:notice]).to eq("Please enter timer value")
            end
            
        end
    end
    #describe 'Index Function' do
        #context "Negative Values" do
            #let(:params) { {timervalue: '-1'} }
                #it "returns : Value should be positive" do
                    #get :index, timervalue: '-1'
                    #expect(flash[:notice].to match(/Invalid timer value. Please set timer value to be at least 1 minute./))
            #end        
        #end
    #end
    describe 'Index questions for Quiz' do
        let!(:question1) { FactoryBot.create(:question_bank, question: 'Test Question1', reviewStatus: "Approved", category: 'cat1', option1: '1', option2: '2', option3: '3', option4: '4', option5: '5', answer: '2')}
        let!(:question2) { FactoryBot.create(:question_bank, question: 'Test Question2', reviewStatus: "Approved", category: 'cat2', option1: '1', option2: '2', option3: '3', option4: '4', option5: '5', answer: '3')}
        let(:params) { {quizlimit: "All"} }
        it 'gets all questions' do
            get :index, quizlimit: "All", timervalue: '100'
            expect(assigns(:questions)).to include(question1,question2)
        end
        it 'missing quizlimit option' do
            get :index, timervalue: '100'
            expect(flash[:notice]).to eq("Select at least one option")
        end
        describe "Number of returned values" do
            before(:each) do 
                FactoryBot.create_list(:question_bank, 200, reviewStatus: "Approved")
            end
            it 'gets only given number of questions = 20' do
                get :index, quizlimit: 1, timervalue: '100'
                expect(assigns(:questions).count).to eq(20)
            end

            it 'gets only given number of questions = 35' do
                get :index, quizlimit: 35, timervalue: '100'
                expect(assigns(:questions).count).to eq(40)
            end

            it 'gets only given number of questions = 45' do
                get :index, quizlimit: 45, timervalue: '100'
                expect(assigns(:questions).count).to eq(60)
            end

            it 'gets only given number of questions = All' do
                get :index, quizlimit: 101, timervalue: '100'
                expect(assigns(:questions).count).to eq(202)
            end
        end
    end

end
