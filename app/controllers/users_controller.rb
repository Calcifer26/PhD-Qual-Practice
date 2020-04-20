class UsersController < ApplicationController
  

  # GET /users
  before_action :logged_in_admin, only: [:index, :show, :edit, :update, :destroy]
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    unless user_signed_in?
      flash[:notice] = "You need to login to see this page"
      redirect_to login_url
    end
    @user= current_user
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.current_place = 0
    	
    if @user.is_admin == true && User.find_by(reviewStatus: "Approved")
        @user.reviewStatus = "Pending"
    elsif  @user.is_admin == true 
        @user.reviewStatus = "Approved"  
    else
        @user.update(reviewStatus: nil)
    end
	    

#    if @user.email == "admin@tamu.edu"
#      @user.is_admin = true
#    else
#      @user.is_admin = false
#    end
         
    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        session[:name] = @user.name
        session[:email] = @user.email
        flash[:notice] = 'Please verify your email.'
        format.html { redirect_to root_url}
        #format.json { render :show, status: :created, location: @user }
        # sign_in(:user, @user)
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to root_url, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy 
    respond_to do |format|
      format.html { redirect_to admin_index_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end    
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
	    params.require(:user).permit(:name, :email, :password, :password_confirmation, :is_admin)
    end
end
