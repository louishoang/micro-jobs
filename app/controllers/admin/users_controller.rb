module Admin
  class UsersController < ApplicationController
    before_filter :admin_authorize!

    def index
      @users = User.paginate(:page => params[:page], :per_page => 10)
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy
      flash[:notice] = "User has been successfully deleted"
      redirect_to admin_users_path
    end

    def show
      @user = User.find(params[:id])
    end
  end
end
