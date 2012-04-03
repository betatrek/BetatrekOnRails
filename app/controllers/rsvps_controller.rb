class RsvpsController < ApplicationController

  # Allows the Rsvp confirmed page to be served statically, since it is the same for all users
  caches_page :show

  # Runs before rendering the RSVP page to create a new Rsvp object
  def new
    @rsvp = Rsvp.new
  end

  # Runs before rendering the confirmed RSVP page to make sure email was confirmed first
  def show
    session[:email] ||= Rsvp.find_by_uid params[:id]
    if not session[:email]
      redirect_to new_rsvp_path
    end
    @email = session[:email]
  end

  # Saves an Rsvp to the database, triggers the email confirmation, and notifies the user whether the save was
  # successful
  def create
    @rsvp = Rsvp.new params[:rsvp]
    if @rsvp.save
      flash.now[:success] = "Thank you, we will send you a link to verify we have the correct email address."
      RsvpMailer.email_confirmation(@rsvp).deliver
      @rsvp = Rsvp.new
    end
    render 'new'
  end

  # Switches the Rsvp to being confirmed and notifies the user, or tells the user something was wrong with the
  # given link
  def confirm
  	rsvp = Rsvp.find_by_uid params[:uid]
  	rsvp.confirm_email params[:confirmation_code]
  	if not rsvp.confirmed?
      flash[:error] = "You're link doesn't match what we have on record."
      redirect_to new_rsvp_path
  	else
      session[:email] = rsvp.email
      flash[:success] = "We will update you at #{rsvp.email} with new information as it because available"
      redirect_to rsvp_path rsvp
  	end 
  end
end
