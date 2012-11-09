class SessionsController < Devise::SessionsController
  def new
  end

  def destroy
    super
  end
end
