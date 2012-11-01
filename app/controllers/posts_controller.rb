require 'facebook_oauth'
class PostsController < ApplicationController

  before_filter :exists?, only: [:show, :destroy, :index]

  def new
    #@user=User.find(params[:id])
    @post=Post.new
    @posts = current_user.posts.paginate(:page => params[:page], :per_page => 10)
 #   @posts = User.where('users.id == authentications.user_id')

    #@posts = @user.posts.paginate(:page => params[:page], :per_page => 10)
    #@authentication = Authentication.find(params[:id])
    #@posts=User.find(@authentication.user_id).posts.paginate(:page => params[:page], :per_page => 10)
  end

  def create
    @post = current_user.posts.build(params[:post])
    if @post.save
      redirect_to new_post_path
      flash[:success] = "Post successfully created!"

    else
      flash[:error] = "Error!"
      render 'new'
    end
  end

  def destroy
    @post=Post.find(params[:id]).destroy
    #@post.destroy
    redirect_to_new_post_path
    flash[:success] = "Post successfully deleted!"

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




  def auth
    @client = FacebookOAuth::Client.new(
        :application_id => '434277789963565',
        :application_secret => '57f32627336bb116989ce62e0df0e759',
        :callback => "http://local.mini-post-app.com/posts/#{params[:post_id]}/callback"
    )
    redirect_to @client.authorize_url
    # access_token = client.authorize(:code => params[:code])
    #@client = client.me.info
  end

  def callback
    @post=Post.find(params[:post_id])
    @client = FacebookOAuth::Client.new(
        :application_id => '434277789963565',
        :application_secret => '57f32627336bb116989ce62e0df0e759',
        :callback => "http://local.mini-post-app.com/posts/#{params[:post_id]}/callback"
    )
    @access_token = @client.authorize(:code => params[:code])
    @client.authorize_url(:scope => 'publish_stream')
    #@post=Post.find(params[:id])
    #logger.info("post contents ###############################{@post.content}")
    @client.me.feed(:create, :message => @post.content)

    redirect_to new_post_path
    #redirect_to users_path
    flash[:success] = "Posted successfully"

  end


  private
  def authorized_user
    @post = Post.find(params[:id])
    redirect_to root_path unless current_user?(@post.user)

  end

  def exists?
    redirect_to signin_path if !signed_in?
  end
end
