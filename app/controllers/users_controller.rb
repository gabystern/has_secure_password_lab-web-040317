class UsersController < ApplicationController
  before_action :authorize_user, only: [:new, :create]

  def new
  end

  def create
    if params[:password] != params[:password_confirmation] || params[:password].blank?
      flash[:notice] = "The passwords you provided do not match or are empty."
      redirect_to users_new_path
    else
      @user = User.new(user_params)
      session[:name] = @user[:name]
      if @user.save
        redirect_to index_path
      else
        render :new
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end


end
