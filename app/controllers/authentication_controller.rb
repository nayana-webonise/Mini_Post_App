require 'omniauth'
require 'omniauth-facebook'

class AuthenticationController < ApplicationController

  #def create
  #  auth = request.env["omniauth.auth"]
  #
  #
  #
  #
  #  logger.info#################################{auth}
  #  # Try to find authentication first
  #  authentication = Authentication.find_by_provider_and_uid(auth['provider'], auth['uid'])
  #  #@auth_user= Authentication.find(params[:id])
  #  #logger.info("auth_user ###############################{@auth_user}")
  #
  #
  #  logger.info("authentication ###############################{@authentication}")
  #  if authentication
  #    # Authentication found, sign the user in.
  #
  #    #redirect_to new_post_path
  #    redirect_to users_path
  #    flash[:notice] = "Signed in successfully."
  #    #sign_in_and_redirect(:user, authentication.user)
  #  else
  #    # Authentication not found, thus a new user.
  #    user = User.new
  #    user.apply_omniauth(auth)
  #    if user.save(:validate => false)
  #    flash[:notice] = "Account created and signed in successfully."
  #   # redirect_to users_path
  #    redirect_to new_post_path
  #   # sign_in_and_redirect(:user, user)
  #    else
  #      flash[:error] = "Error while creating a user account. Please try again."
  #      redirect_to root_url
  #    end
  #  end
  #end



  before_filter :authenticate_user!, :only => :destroy

  def create
    omniauth = request.env['omniauth.auth']
    logger.info("omniauth ###############################{omniauth}")
    authentication = Authentication.find_by_provider_and_uid(omniauth["provider"], omniauth["uid"])
    if current_user
      if authentication && authentication.try(:user) != current_user
        flash[:error] = I18n.t("This %{provider} account is already connected to another account in our service", :provider => authentication.provider)
      elsif authentication.nil?
        current_user.authentications.create!(:provider => omniauth["provider"], :uid => omniauth["uid"])
      end
      redirect_to root_path
    else # user logged out
      if authentication # sign in user
       # sign_in_and_redirect :user, authentication.user
        sign_in(authentication.user)
        redirect_to new_post_path
      else # create new user

        user = User.new
           user.apply_omniauth(omniauth)
           if user.save(:validate => false)
           flash[:notice] = "Account created and signed in successfully."
          # redirect_to users_path
           sign_in(user)
           redirect_to new_post_path
           flash[:notice] = "Account created and signed in successfully."
          # sign_in_and_redirect(:user, user)
           else

             redirect_to root_url
             flash[:error] = "Error while creating a user account. Please try again."
           end
        #user = User.new.tap {|user| user.apply_omniauth(omniauth) }
        #if user.save
        #  sign_in(authentication.user)
        #  redirect_to new_post_path
        #else
        #  session["omniauth"] = omniauth
        # redirect_to new_post_path
        #end
      end
    end
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    redirect_to :back
  end



end
