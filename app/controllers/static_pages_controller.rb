class StaticPagesController < ApplicationController
  def home
  	redirect_to new_rsvp_path
  end

  def help
  end
end
