class StaticPagesController < ApplicationController
  def home
  	redirect_to rsvp_path
  end

  def help
  end
end
