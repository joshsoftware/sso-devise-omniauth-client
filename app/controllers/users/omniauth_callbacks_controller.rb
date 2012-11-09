class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def josh_id
    omniauth = env['omniauth.auth']
    logger.debug "+++ #{omniauth}"

    user = User.find_by_uid(omniauth['uid'])
    if not user
      # New user registration
      user = User.new(:uid => omniauth['uid'])
    end    
    user.first_name = omniauth['extra']['first_name']
    user.last_name  = omniauth['extra']['last_name']
    user.save

    #p omniauth

    # Currently storing all the info
    session[:user_id] = omniauth

    sign_in_and_redirect user, :event => :authentication #this will throw if @user is not activated
    set_flash_message(:notice, :success, :kind => "JoshId") if is_navigational_format?
  end
  
  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end
  
  protected
  
    def after_omniauth_failure_path_for resource
      new_user_session_path
    end
end

