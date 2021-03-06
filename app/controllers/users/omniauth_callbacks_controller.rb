class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def facebook
      # You need to implement the method below in your model (e.g. app/models/user.rb)
      @user = User.from_omniauth(request.env["omniauth.auth"])
      if @user.persisted?
        sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
        set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
      else
        # save the current omniauth info
        @user.is_admin = false
        @user.skip_confirmation!
        @user.save
        # @user.confirm!
        session["devise.auth_data"] = request.env["omniauth.auth"]
        sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      end
    end
  
    def google_oauth2
      # You need to implement the method below in your model (e.g. app/models/user.rb)
      @user = User.from_omniauth(request.env["omniauth.auth"])
      
      if @user.persisted?
        sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
        set_flash_message(:notice, :success, :kind => "Google") if is_navigational_format?
      else
        # save the current omniauth info
        @user.skip_confirmation!
        @user.is_admin = false
        @user.save
        session["devise.auth_data"] = request.env["omniauth.auth"]
        sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
        # set_flash_message(:notice, :success, :kind => "Google") if is_navigational_format?
        #redirect_to new_user_registration_url
      end
    end

    def failure
      redirect_to root_path
    end
  end
  
