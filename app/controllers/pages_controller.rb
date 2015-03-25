class PagesController < ApplicationController

	include ApplicationHelper
	
  def index
  	@new_reservation = Reservation.new

  	todaysReservation(Time.zone.now.strftime("%Y-%m-%d"))
	  setTime()
  	setMember()
  	setContent()
	end

end
