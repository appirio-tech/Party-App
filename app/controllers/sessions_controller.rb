class SessionsController < ApplicationController
  def create
    @user = User.from_auth(auth)
    session[:user_id] = @user.id
    redirect_to session.delete(:return_to) || root_url
  end

  def destroy
    reset_session
    redirect_to '/'
  end

  protected

  def auth
    request.env['omniauth.auth']
  end
end
