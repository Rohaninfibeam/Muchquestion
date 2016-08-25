class UserController < Devise::OmniauthCallbacksController
  # skip_before_filter :authenticate_user!
  skip_load_and_authorize_resource
  def google_oauth2
  	@user=User.from_google(request.env["omniauth.auth"])
  	sign_in_and_redirect @user
  end
end
