class UserController < ApplicationController
  def create
  	omniauthreturn=request.env["omniauth.auth"]
  	omniauthreturn.info.inspect
  end
end
