class QuestionsController < ApplicationController
    
    before_action :logged_in_user, only: [:create, :new]
    
    def question_params
        params.require(:question).permit(:category, :question, :option1, :option2, :option3, :option4, :option5, :answer,:image1,:image2,:image3,:image4,:image5,:imagequestion, :explaination, :bookmark)
    end
    
    def index
        if(params[:id])
           @user_questions = [QuestionBank.find(params[:id])]
        else
            @user_questions = QuestionBank.where(creator: current_user.email)
        end
        @categories_all = CategoryBank.all
    end

    def new
        @categories_all = CategoryBank.all
    end
    
    def create
        @categories_all = CategoryBank.all
	    @question = QuestionBank.create!(question_params)
        @question.update(creator: current_user.email)
        @question.update(reviewStatus: "Pending")

        if params[:imagequestion].present?
            preloaded = Cloudinary::PreloadedFile.new(params[:imagequestion])
            @question.update(question: preloaded.identifier)
        end
        if params[:image1].present?
            preloaded = Cloudinary::PreloadedFile.new(params[:image1])
            @question.update(option1: preloaded.identifier)
        end
        if params[:image2].present?
            preloaded = Cloudinary::PreloadedFile.new(params[:image2])
            @question.update(option2: preloaded.identifier)
        end
        if params[:image3].present?
            preloaded = Cloudinary::PreloadedFile.new(params[:image3])
            @question.update(option3: preloaded.identifier)
        end
        if params[:image4].present?
            preloaded = Cloudinary::PreloadedFile.new(params[:image4])
            @question.update(option4: preloaded.identifier)
        end
        if params[:image5].present?
            preloaded = Cloudinary::PreloadedFile.new(params[:image5])
            @question.update(option5: preloaded.identifier)
        end
       
        flash[:success] = "Question was successfully added"
        if current_user.reviewStatus == "Approved"
       	    redirect_to admin_questions_path
	    else
            redirect_to questions_path
	    end
    end
    
    def edit
        @categories_all = CategoryBank.all
        @question = QuestionBank.find(params[:id])
       # redirect_to questions_path(@question)
    end
    
    def update
        @categories_all = CategoryBank.all
        @question = QuestionBank.find(params[:id])
        @question.update_attributes!(question_params)
        if params[:imagequestion].present?
            preloaded = Cloudinary::PreloadedFile.new(params[:imagequestion])
            @question.update(question: preloaded.identifier)
        end
        if params[:image1].present?
            preloaded = Cloudinary::PreloadedFile.new(params[:image1])
            @question.update(option1: preloaded.identifier)
        end
        if params[:image2].present?
            preloaded = Cloudinary::PreloadedFile.new(params[:image2])
            @question.update(option2: preloaded.identifier)
        end
        if params[:image3].present?
            preloaded = Cloudinary::PreloadedFile.new(params[:image3])
            @question.update(option3: preloaded.identifier)
        end
        if params[:image4].present?
            preloaded = Cloudinary::PreloadedFile.new(params[:image4])
            @question.update(option4: preloaded.identifier)
        end
        if params[:image5].present?
            preloaded = Cloudinary::PreloadedFile.new(params[:image5])
            @question.update(option5: preloaded.identifier)
        end
        flash[:success] = "Question-#{@question.id} was successfully updated."
        redirect_to questions_path(@question)
    end
    
    def destroy
        @question = QuestionBank.find(params[:id])
        @question.destroy
        flash[:destroy] = "Question-'#{@question.id}' deleted."
        redirect_to questions_path
    end
    
end
