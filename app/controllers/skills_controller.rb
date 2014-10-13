class SkillsController < ApplicationController
  # this should be listed under admin namespacing but
  # I finished this page before admin namespacing and don't have
  # enought time to fix.

  before_filter :admin_authorize!

  def index
    @skills = Skill.all
  end

  def new
    @skill = Skill.new
  end

  def create
    @skill = Skill.new(skill_params)
    if @skill.save
      redirect_to skills_path
      flash[:notice] = "Your record has been created successfully!"
    else
      flash[:notice] = "Your record could not be completed"
      render "new"
    end
  end

  private

  def skill_params
    params.require(:skill).permit(:name, :description)
  end
end
