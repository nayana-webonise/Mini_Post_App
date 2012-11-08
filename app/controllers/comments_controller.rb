class CommentsController < ApplicationController
  def create
    @post=Post.find(params[:post_id])
    @comment =@post.comments.new(:body => params[:comment_body])
    if @comment.save
      @comments=@post.comments
      flash[:success] = "comment created!"
      respond_to do |format|
        format.js
      end
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
