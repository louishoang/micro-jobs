class UsersController < ApplicationController
  before_action :authenticate!, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update]
  before_action :authorize_user!, only: [:edit, :update]
  helper_method :sort_column, :sort_direction

  def index
    @geojson = []

    if params[:search]
      search = params[:search]
      @users = User.combined_search(search)
    else
      @users = User.all
    end

    @users.each do |user|
      next unless user.longitude && user.latitude
      @geojson << {
        type: 'Feature',
        geometry: {
          type: 'Point',
          coordinates: [user.longitude, user.latitude]
        },
        properties: {
          role: "User",
          name: user.first_name + ' ' + user.last_name,
          address: user.address,
          email: user.user_name,
          image: user.avatar_url,
          id: user.id,
          :'marker-size' => 'medium',
          :'marker-symbol' => 'rocket',
          :'marker-color' => '#fa0'
        }
      }
    end

    respond_to do |format|
      format.html
      format.json { render json: @geojson }
    end
  end

  def show
    @jobs = @user.jobs.order(sort_column + " " + sort_direction)
    @avatar = @user.avatar_url
    @user_name = @user.user_name
    @first_name = @user.first_name
    @last_name = @user.last_name
    @address = @user.address
  end

  def edit
  end

  def update
    params[:user][:skill_ids].pop
    @skills_list = params[:user][:skill_ids]
    if @user.update(user_params)
      @old_skills = UserSkillAssociation.where(user_id: current_user.id)
      @old_skills.destroy_all
      @skills_list.each do |skill_id|
        UserSkillAssociation.create(user_id: @user.id, skill_id: skill_id )
      end
      flash[:notice]= "User profile is updated successfully"
      redirect_to user_path(@user)
    end
  end

  private

  def sort_column
    @user.jobs.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :address, :skills_ids => [] )
  end

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_user!
    unless @user == current_user
      redirect_to root_url,
        notice: "You need to sign in!"
    end
  end
end
