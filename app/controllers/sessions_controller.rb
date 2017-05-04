class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(name: params[:name])
    return head(:forbidden) unless @user.authenticate(params[:password])
    if @user.present?
      session[:name] = @user[:name]
      redirect_to index_path
    else
      flash[:notice] = "The username you provided did not match our records. Please double check and try again."
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    redirect_to login_path
  end

end
