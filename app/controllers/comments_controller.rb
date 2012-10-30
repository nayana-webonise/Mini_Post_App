class CommentsController < ApplicationController
  def create
    @post=Post.find(params[:post_id])
    @comment =@post.comments.new(params[:comment])
    if @comment.save
      redirect_to post_path @post
      flash[:success] = "Successfully commented on post"
    else
      redirect_to new_post_path
      flash[:error] = "Error "
    end
  end

  def new
    @comment=Comment.new

  end

  def show
    @comment = Comment.first
    @comment=Comment.find params[:id]
  end

end
