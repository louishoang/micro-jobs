class SessionsController < ApplicationController
  def create
    @user = User.find_or_create_from_auth_hash(auth_hash)
    session[:user_id] = @user.id
    set_current_user(@user)
    flash[:notice] = "Successfully signed in as #{@user.first_name + ' ' + @user.last_name}."
    redirect_to user_path(current_user)
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Signed out successfully."

    redirect_to root_path
  end

  def failure
    flash[:alert] = "Unable to sign in."

    redirect_to root_path
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
