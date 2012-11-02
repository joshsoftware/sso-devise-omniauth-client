class UserSessionsController < ApplicationController
  before_filter :login_required, :only => [ :destroy ]

  respond_to :html

  # omniauth callback method
  def create
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

    flash[:notice] = "Successfully logged in"
    redirect_to root_path
  end

  # Omniauth failure callback
  def failure
    flash[:notice] = params[:message]

  end

  # logout - Clear our rack session BUT essentially redirect to the provider
  # to clean up the Devise session from there too !
  def destroy
    session[:user_id] = nil

    flash[:notice] = 'You have successfully signed out!'
    redirect_to "#{CUSTOM_PROVIDER_URL}/users/sign_out"
  end
end
