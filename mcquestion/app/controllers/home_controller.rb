class HomeController < ApplicationController
  skip_before_filter :authenticate_user!
  skip_load_and_authorize_resource 
  def login
  end
end
