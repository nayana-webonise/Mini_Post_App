class UsersController < ApplicationController
  before_filter :exists?, only: [:show]

  def new
    @user=User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Successfully Signed up"
      redirect_to new_session_path
    else
      @title = "Sign up"
      render 'new'
  end
  end


  def show
    @user=User.find(params[:id])

  end

  def index

  end

  def exists?
    redirect_to root_url if !signed_in?
  end

end
