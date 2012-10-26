class PostsController < ApplicationController

  before_filter :exists?, only: [:show, :destroy, :index]

   def new
     @post=Post.new
     @posts = current_user.posts.paginate(:page => params[:page], :per_page => 10)
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
    @post=Post.find(params[:id]).destroy
    #@post.destroy
    redirect_to users_path

  end

  def index


   # @posts = Post.paginate(:page => params[:page], :per_page => 1)
    @all=current_user.posts
    @posts=Post.all
  end

   def show
   @posts = Post.paginate(:page => params[:page], :per_page => 1)
    @post=Post.find(params[:id])
    #@posts=Post.all
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
