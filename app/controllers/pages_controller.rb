class PagesController < ApplicationController
  def index
  	@new_reservation = Reservation.new
  	#binding.pry
  	#params[:day] = Date.today.strftime('%Y-%m-%d')
  end

end
