class CommentsController < ApplicationController
  def create
    @post=Post.find(params[:post_id])
    @comment =@post.comments.new(params[:comment])
    if @comment.save
      flash[:success] = "comment created!"
      redirect_to post_path @post
    else
      redirect_to new_post_path
    end
    # redirect_to root_path(@micropost)
  end
  def new
    @comment=Comment.new

  end

  def show
    @comment = Comment.first
    @comment=Comment.find params[:id]

    #@title = @user.name
  end


end
