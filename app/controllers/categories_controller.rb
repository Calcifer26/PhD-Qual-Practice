class CategoriesController < ApplicationController
    
    before_action :logged_in_user, only: [:create, :new]
    
    def category_params
        params.require(:category_banks).permit(:category)
        #params.permit(:category_new)
    end
    
    def index
        #@questions = QuestionBank.where(creator: session[:email])
        @all_categories = CategoryBank.all
        @user = User.all
	#redirect_to categories_path
    end
    
    def create
	@all_category = CategoryBank.create!(category_params)
        @all_category.update(creator: current_user.email)
        @all_category.update(reviewStatus: "Pending")
	redirect_to categories_path
    end

    def show
        @all_category = CategoryBank.find(params[:id])
        @all_category.update(reviewStatus: "Approved")
        redirect_to categories_path
    end

    
    def edit
        @all_category = CategoryBank.find(params[:id])
        #redirect_to questions_path(@question)
    end
    
    def update

        @all_category = CategoryBank.find(params[:id])
        @all_category.update_attributes!(category_params)
        if params[:category].present?
            #preloaded = Cloudinary::PreloadedFile.new(params[:category])
            @all_category.update(category: preloaded.identifier)
        end
        flash[:success] = "Category-#{@all_category.id} was successfully updated."
        redirect_to categories_path(@all_category)
    end
    
    def destroy
        @all_category = CategoryBank.find(params[:id])
        @all_category.destroy
        flash[:destroy] = "Category-'#{@all_category.category}' deleted."
        redirect_to categories_path
    end    
end
