class UsersController < ApplicationController
  before_filter :authenticate!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
   @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice]= "User profile is updated successfully"
      redirect_to user_path(@user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :address)
  end
end
