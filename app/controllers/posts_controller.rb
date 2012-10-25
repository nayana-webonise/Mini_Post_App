class PostsController < ApplicationController

  before_filter :exists?, only: [:show, :destroy, :index]

   def new
     @post=Post.new
     @posts = current_user.posts
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
    @all=current_user.posts
    @posts=Post.all
  end

   def show
    @post=Post.find(params[:id])
    @comment = @post.comments.new
    @comments =@post.comments
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
