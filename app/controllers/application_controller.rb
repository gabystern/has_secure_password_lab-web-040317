class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  private

  def current_user
    @current_user = User.find_by(name: session[:name])
  end

  def authorize_user
    if !logged_in?
      flash[:notice] = 'You are not allowed to do that unless you are logged in'
      redirect_to login_path
    end
  end

  def logged_in?
    !!session[:name]
  end

end
