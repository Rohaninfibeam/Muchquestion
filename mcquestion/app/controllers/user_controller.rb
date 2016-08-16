class UserController < Devise::OmniauthCallbacksController
  def google_oauth2
  	@user=User.from_google(request.env["omniauth.auth"])
  	sign_in_and_redirect @user
  end
end
