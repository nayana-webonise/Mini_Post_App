require 'omniauth'
require 'omniauth-facebook'

class AuthenticationController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]

    # Try to find authentication first
    authentication = Authentication.find_by_provider_and_uid(auth['provider'], auth['uid'])

    if authentication
      # Authentication found, sign the user in.
      flash[:notice] = "Signed in successfully."
      #redirect_to new_post_path
      redirect_to users_path
      #sign_in_and_redirect(:user, authentication.user)
    else
      # Authentication not found, thus a new user.
      user = User.new
      user.apply_omniauth(auth)
      if user.save(:validate => false)
      flash[:notice] = "Account created and signed in successfully."
      sign_in_and_redirect(:user, user)
      else
        flash[:error] = "Error while creating a user account. Please try again."
        redirect_to root_url
      end
    end
  end



  #def index
  #  @authentications = current_user.authentications if current_user
  #end
  #
  #def create
  #  auth = request.env["rack.auth"]
  #  current_user.authentications.find(auth['provider'], auth['uid'])
  #  flash[:notice] = "Authentication successful."
  #  redirect_to new_post_path
  #end
  #
  #def destroy
  #  @authentication = current_user.authentications.find(params[:id])
  #  @authentication.destroy
  #  flash[:notice] = "Successfully destroyed authentication."
  #  redirect_to authentications_url
  #end



end
