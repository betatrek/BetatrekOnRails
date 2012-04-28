class UsersController < ApplicationController
	before_filter :signed_in_user, only: [:edit, :update]
	before_filter :correct_user,   only: [:edit, :update]
	before_filter :admin_user,     only: [:index, :destory]

	def show
		@user = User.find params[:id]
	end

	# Runs before rendering the sign up page to create a new user
	def new
		@user = User.new
	end

    # Saves an User to the database, triggers the email confirmation, and notifies the user whether the save was
    # successful
	def create
		@user = User.new params[:user]
		if @user.save
			session[:user] = nil
			flash[:success] = "Thank you, we will send you a link to verify we have the correct email address."
			sign_into_session @user, permanently: false		
			UserMailer.delay.email_confirmation(@user)	
			redirect_to dashboard_path
		else
			session[:user] = @user
			redirect_to signup_path
		end
	end

	# Switches the User to being confirmed and notifies the user, or tells the user something was wrong with the
  	# given link
  	def confirm
  		user = User.find_by_uid params[:uid]
  		user.confirm_email params[:confirmation_code]
  		if not user.confirmed?
      		flash[:error] = "You're link doesn't match what we have on record."
      		redirect_to signup_path
  		else
      		session[:user] = user
      		flash[:success] = "We will update you at #{user.email} with new information as it because available"
      		redirect_to dashboard_path
  		end 
  	end
end
