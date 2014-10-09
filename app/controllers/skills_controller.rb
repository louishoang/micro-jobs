class SkillsController < ApplicationController
  # for now anyone can add skill but inthe future only admin can
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
