class PostsController < ApplicationController

  before_filter :exists?, only: [:show, :destroy, :index]

   def new
     @post=Post.new
   end

  def create
    @post = current_user.posts.build(params[:post])
    if @post.save
      flash[:success] = "Post created!"
      redirect_to posts_path
    else
      flash[:error] = "Error!"
      render 'new'
    end
  end

  def destroy
    @post.destroy
    redirect_back_or root_path

  end

  def index
   @posts=current_user.posts
  end

   def show
    @post=Post.find(params[:id])
   end

  def new_comment
    @post=Post.find(params[:id])
    @comment =@post.comments.build(params[:comment])
  end

  def create_comment
    #@post=Post.find(params[:id])
    #logger.info("@@@@@@@@@--@post---@@@@@@@@@@@@@@#{@post.inspect}")

    @comment1 =@post.comments.build(params[:comment])
    if @comment1.save
      flash[:success] = "comment created!"
      redirect_to post_path @post
    else
      redirect_to root_path
    end

  end

  private
  def authorized_user
    @post = Post.find(params[:id])
    redirect_to root_path unless current_user?(@post.user)

  end

   def exists?
     redirect_to root_url if !signed_in?
   end
end
