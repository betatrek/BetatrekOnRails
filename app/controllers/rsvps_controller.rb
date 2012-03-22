class RsvpsController < ApplicationController
  def new
    @rsvp = Rsvp.new
  end

  def create
    @rsvp = Rsvp.new params[:rsvp]
    if @rsvp.save
      flash[:success] = "Thank you, we will send you a link to confirm we have the correct email address."
      @rsvp.errors.clear
    end
    render 'new'
  end

  def confirm
  	user = Rsvp.find_by_uid params[:uid]
  	user.confirm_email params[:confirmation_code]
  	if not user.confirmed?
  		flash[:error] = "You're link doesn't match what we have on record."
  		redirect_to rsvps_new_path
  	else
  		render 'confirm'
  	end
  end
end
