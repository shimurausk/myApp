class PagesController < ApplicationController

	include ApplicationHelper
	
  def index
  	@new_reservation = Reservation.new
	  setTime()
  	setMember()
  	setContent()
	end

end
