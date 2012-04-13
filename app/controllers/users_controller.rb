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

	def create
		@user = User.new params[:user]
		if @user.save
			sign_into_session @user, permanently: false
			redirect_to 'new'#portfolio_creation_path
		else
			render 'new'
		end
	end
end
