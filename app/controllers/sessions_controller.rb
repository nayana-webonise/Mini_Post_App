class SessionsController < ApplicationController
  def new
    render 'new'
  end

  def current_user?(user)
    user == current_user
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])

      sign_in user

      #render 'shared/post_form'
       redirect_to new_post_path
    else
      flash[:error] = 'Invalid email/password combination' # Not quite right!
      redirect_to new_session_path
    end
  end


  def destroy
    sign_out
    redirect_to root_url
  end

  private

  def authenticate
    deny_access unless signed_in?
  end

end
