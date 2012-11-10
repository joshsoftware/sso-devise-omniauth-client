class SessionsController < Devise::SessionsController
  def new
    redirect_to user_omniauth_authorize_path(:josh_id)
  end

  def destroy
    sign_out current_user
    redirect_to OmniAuth::Strategies::JoshId::SIGN_OUT_URL
  end
end
