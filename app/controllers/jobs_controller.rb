class JobsController < ApplicationController
  before_action :authenticate!, only: [:new, :edit, :update]
  before_action :find_job, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]
  # before_action owner?(job), only: [:edit, :update, :destroy]

  def index
    @geojson = []
    if params[:search]
      search = params[:search]
      @jobs = Job.combined_search(search)
    else
      @jobs = Job.all
    end

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
          location: job.location,
          image: job.employer.avatar_url,
          :'marker-size' => 'medium',
          :'marker-symbol' => 'marker-stroked',
          :'marker-color' => '#fa0'
        }
      }
    end

    respond_to do |format|
      format.html
      format.json {render json: @geojson}
    end
  end

  def show
    @user = @job.employer
    @avatar = @user.avatar_url
    @skills = @job.skills
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
    @job_skill_association = JobSkillAssociation.new
  end

  def create
    @job = Job.new(job_params)

    @job.employer_id = current_user.id
    params[:job][:skill_ids].shift
    @skills_list = params[:job][:skill_ids]

    if @job.save
      @skills_list.each do |skill_id|
        JobSkillAssociation.create(job_id: @job.id, skill_id: skill_id )
      end
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
    params.require(:job).permit(:name, :location, :budget, :description, :skills_ids => [])
  end

  def find_job
    @job = Job.find(params[:id])
  end

  def authorize_user!
    binding.pry
    unless @user == current_user
      redirect_to root_url,
        notice: "You need to sign in!"
    end
  end
end
