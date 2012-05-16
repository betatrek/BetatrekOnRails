class SessionsController < ApplicationController

	def new
  	end

  	def create
  		user = User.find_by_email params[:email]
  		if user && user.authenticate(params[:password])
  			sign_into_session user, permanently: true
  			redirect_back_or dashboard_path
  		else
  			flash[:error] = t :invalid_credentials
  			redirect_back_or signup_path
  		end
  	end

  	def destroy
  	end
end
