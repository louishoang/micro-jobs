class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def index
    @comments = Comment.all
  end

  def show
  end

  def new

    @comment = Comment.new
  end

  def edit
  end

  def create
    @user = current_user
    @comment = Comment.new(comment_params)
    @comment.user_id = params[:user_id]
    if @comment.save
      redirect_to user_path(@user)
      flash[:notice] = "Your record has been created successfully!"
    else
      flash[:notice] = "Your record could not be completed"
      render "new"
    end
  end

  private
    def set_comment
      @comment = Comment.find(params[:user_id])
    end

    def comment_params
      params.require(:comment).permit(:user_id, :author, :text)
    end
end
