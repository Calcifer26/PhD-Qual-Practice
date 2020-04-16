class AdminController < ApplicationController

  before_action :logged_in_admin, only: [:index, :show, :admin_questions]
  before_action :delete_users, only: [:index]
  
  def index
    @users = User.all
    @all_categories = CategoryBank.all
  end
  
  def admin_questions
    @questions = QuestionBank.all
  end

  def admin_categories
    @questions = CategoryBank.all
  end

  def show
    if params[:flag_] == "q"
      @question = QuestionBank.find(params[:id])
    	@question.update(reviewStatus: "Approved")
    	redirect_to action: "admin_questions"
    	
    elsif params[:flag_] == "u"
	@user = User.find(params[:id])
	@user.update(reviewStatus: "Approved")
	redirect_to action: "index"
    end
    return
  end


  def destroy
    if params[:flag] == "q"
    	@question = QuestionBank.find(params[:id])
    	@question.destroy
    	flash[:destroy] = "Question-'#{@question.id}' deleted."
    	redirect_to admin_questions_path
    elsif (params[:flag] == "u") 
      @user = User.find(params[:id])
	      if @user.id != current_user[:id]
	         @user.destroy
    	     flash[:destroy] = "User/Admin-'#{@user.email}' deleted."
    	     redirect_to admin_index_path
        else
	          flash[:destroy] = "You cannot delete your own account."
	          redirect_to admin_index_path
	      end
    end
  end
    
  def delete_users
  #  if logged_in? && is_admin?
      User.delete_old_users;
   # end
  end
end

