module Admin
  class JobsController < ApplicationController
    before_filter :admin_authorize!

    def index
      if params[:search]
        @jobs = Job.search(params[:search]).order("name")
      else
        @jobs = Job.paginate(:page => params[:page], :per_page => 5).order("name")
      end
    end

    def destroy
      @job = Job.find(params[:id])
      if @job.destroy
        flash[:notice] = "Job has been successfully deleted"
        redirect_to admin_jobs_path
      end
    end

    def show
      @job = Job.find(params[:id])
    end
  end
end
