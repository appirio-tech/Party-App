class ApplicationController < ActionController::Base
  before_filter :conference_required
  protect_from_forgery
  layout 'application'

  protected

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def signed_in?
    !!current_user
  end

  helper_method :current_user, :signed_in?
  def login_required
    unless signed_in?
      session[:return_to] = request.url
      redirect_to '/sign_in'
    end
  end

  def current_conference
    @conference ||= Conference.from_request(request)
  end
  helper_method :current_conference

  def conference_required
    render text: '404 Not Found', status: 404 unless current_conference
  end

  def admin_required
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['ADMIN_USER'] && password == ENV['ADMIN_PASSWORD']
    end
  end
end
