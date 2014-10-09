class JobsController < ApplicationController
  before_action :authenticate!, only: [:new, :edit, :update]
  before_action :find_job, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update]

  def index
    @geojson = []
    if params[:search]
      search = params[:search]
      @jobs = Job.where("name ILIKE :search", search: search)
    else
      @jobs = Job.all
      @jobs.each do |job|
        next unless job.longitude && job.latitude

        @geojson << {
          type: 'Feature',
          geometry: {
            type: 'Point',
            coordinates: [job.longitude, job.latitude]
          },
          properties: {
            role: "Job",
            name: job.name,
            id: job.id,
            :'marker-size' => 'medium',
            :'marker-symbol' => 'marker-stroked',
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
    @user = @job.user
    @avatar = @user.avatar_url
  end

  def edit
  end

  def update
    if @job.update(job_params)
      flash[:notice]= "Job is updated successfully"
      redirect_to job_path(@job)
    end
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    @job.employer_id = current_user.id
    if @job.save
      redirect_to job_path(@job)
      flash[:notice] = "Your record has been created successfully!"
    else
      flash[:notice] = "Your record could not be completed"
      render "new"
    end
  end

  def destroy
    if @job.destroy
      flash[:notice] = "Your record has been deleted successfully!"
    end
    redirect_to @job
  end

  private
  def job_params
    params.require(:job).permit(:name, :location, :budget, :description)
  end

  def find_job
    @job = Job.find(params[:id])
  end

  def authorize_user!
    unless @user == current_user
      redirect_to root_url,
        notice: "You need to sign in!"
    end
  end
end
