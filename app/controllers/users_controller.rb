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

end
