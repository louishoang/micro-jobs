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
    @user = User.find(params[:user_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = params[:user_id]
    if @comment.save
      respond_to do |format|
        format.html do
          flash[:success] = "Your comment has been created successfully!"
          redirect_to user_path(@user)
        end
      format.js
      end
    end
  end

  private
    def set_comment
      @comment = Comment.find(params[:user_id])
    end

    def comment_params
      params.require(:comment).permit(:author, :text)
    end
end
