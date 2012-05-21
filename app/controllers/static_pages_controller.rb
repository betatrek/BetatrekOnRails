class StaticPagesController < ApplicationController
  layout :choose_layout
  before_filter :authenticate, only: [:signup, :dashboard]
  before_filter :signed_in?, only: [:dashboard]

  # Root page, redirects user to the RSVP page until further notice
  def home
  	redirect_to new_rsvp_path
  end

  def help
  end

  # Runs before rendering the sign up page, to initial the user object
  def signup
  	@user = session[:user] || User.new
  	render 'users/new'
  end

  # Runs before rendering the user dashboard
  def dashboard
    @user = current_user
  end

  private

    # Specfies the layout to use based on which action was called
    def choose_layout    
      if [ 'signup', 'login', 'dashboard' ].include? action_name
        'betatrek'
      else
        'application'
      end
    end
end
