class UsersController < ApplicationController
  before_action :authenticate!, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update]
  before_action :authorize_user!, only: [:edit, :update]

  def index
    @geojson = []
    @users = User.all # just for temporary usage
    if params[:search]
      @pg_search_documents = PgSearch.multisearch(params[:search])
    else
      @users = User.all
      @users.each do |user|
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
    end

    respond_to do |format|
      format.html
      format.json {render json: @geojson}
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice]= "User profile is updated successfully"
      redirect_to user_path(@user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :address)
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
