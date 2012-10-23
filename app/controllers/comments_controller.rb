class CommentsController < ApplicationController

  def new
    @comment=Comment.new
  end

  def create
    @post=Post.find(params[:post_id])
    logger.info("@@@@@@@@@--@post---@@@@@@@@@@@@@@#{@post.inspect}")
    @comment =@post.comments.new(params[:comment])
    if @comment.save
      flash[:success] = "comment created!"
      redirect_to post_path @post
    else
      redirect_to root_path
    end

  end

  def show
    @comment=Comment.find(params[:id])
  end
end
