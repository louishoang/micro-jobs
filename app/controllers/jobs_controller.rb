class JobsController < ApplicationController
  def index
    @jobs = Job.all
  end

  def show
    @job = Job.find(params[:id])
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)

    if @job.save
      redirect_to jobs_path
      flash[:notice] = "Your record has been created successfully!"
    else
      flash[:notice] = "Your record could not be completed"
      render "new"
    end
  end

  private
  def manufacturer_params
    params.require(:job).permit(:name, :location, :budget)
  end
end
