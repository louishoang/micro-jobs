class JobsController < ApplicationController
  before_action :authenticate!, only: [:edit, :update]
  before_action :find_job, only: [:show, :edit, :update]
  before_action :authorize_user!, only: [:edit, :update]

  def index
    @jobs = Job.all
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
