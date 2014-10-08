class JobsController < ApplicationController
  before_action :authenticate!, only: [:edit, :update]
  before_action :find_job, only: [:show, :edit, :update]
  before_action :authorize_user!, only: [:edit, :update]

  def index
    @geojson = []
    if params[:search]
      search = params[:search]
      @jobss = Job.where("name ILIKE :search", search: search)
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
