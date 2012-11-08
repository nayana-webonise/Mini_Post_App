
class UsersController < ApplicationController

  before_filter :exists?, only: [:show,:index]

  def new
    @user=User.new

  end

  def create
    @user = User.new(params[:user])

    if @user.save
      redirect_to new_session_path
      flash[:success] = "Successfully Signed up"
    else
      @title = "Sign up"
      render 'new'
    end
  end


  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    end
  end

  def show
    @user=User.find(params[:id])
    @posts = @user.posts.paginate(:page => params[:page], :per_page => 10)
    @following_posts=@user.following.paginate(:page => params[:page])
    @comment=Comment.new
  end

  def subscribe
    @user=User.find(params[:id])
    @other_posts = @user.posts.paginate(:page => params[:page], :per_page => 10)
    @comment=Comment.new
    redirect_to users_path
  end

  def index
    @users = User.paginate(:page => params[:page], :per_page => 10)
  end


  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(:page => params[:page])
    render 'show_follow'
  end
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(:page => params[:page])
    render 'show_follow'
  end

  def exists?
    redirect_to signin_path if !signed_in?
  end

end
