class SessionsController < ApplicationController
  def new
   
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    
    # @user = User.where(email: params[:session][:email]).first
    
    if @user.nil?
      session[:goto] = ("Please consider signing up: " )
      session[:email] = params[:session][:email] 
      session[:password] = params[:session][:password]
      session[:user_id] = nil
      redirect_to register_url
      session[:flash] = ""
      return
    end
    # check whether user is confirmed.
    if !@user.confirmed?
      flash[:notice] = ("Please verify your email")
      redirect_to root_url
    end

    if @user && @user.authenticate(params[:session][:password])
      session[:email] = @user.email 
      session[:name] = @user.name
      session[:user_id] = @user.id
      #@user.update_attribute(:last_login_at, Time.now)
      session[:flash] = ("Welcome: " +( @user.name ? @user.name : @user.email) )
      sign_in_and_redirect @user, :event => :authentication
      # credirect_to root_url
      return
    else
      flash[:notice] = ("Invalid Username or Password")
      redirect_to login_url
      return
    end
  end

  def destroy
    sign_out current_user
    # session[:email] = nil
    # session[:name] = nil
    # session[:user_id] = nil
    # session[:password] = nil
    # session.delete("devise.facebook_data")
    
    flash[:success] = ("Succesfully logged out")
    redirect_to login_url
    return
  end
  
end
