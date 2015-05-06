class ReservationsController < ApplicationController

include ApplicationHelper

	def index

		allReservation
		@new_reservation = Reservation.new

		setTime()
  	setMember()
  	setContent()

	end

	def show
		# @reservation = Reservation.find(params[:id])
	end

	def list
		searchReservation(params[:day])

		if params[:day].match(/:/)
			search_time =  Time.zone.parse(params[:day])
			unless @search_reservation.include?(search_time.strftime('%H').to_i)
				@not_reservation_text = "申し訳ございません。満席となっております。"
			end
		end

		allReservation
		@new_reservation = Reservation.new
	end

	def new
		@new_reservation = Reservation.new

		@new_reservation[:day] = params[:reservation][:day] + ' ' + params[:daytime]

		todaysReservation(params[:reservation][:day])
		setStaff()
		setTime()
		setMember()
		setContent()
	end

	def confirm
  	@new_reservation = Reservation.new(reservation_params)

  	setStaff()
  	setTime()
  	setMember()
  	setContent()

  	if @new_reservation.staff_id.nil?
  		@staff_name = Staff.first[:name]
	  else 
	  	@staff_name = Staff.all[@new_reservation.staff_id][:name]
	  end

  	if @new_reservation.valid?
  		render :action => 'confirm'
  	else
  		render :action => 'new'
  	end

  end

  def create
  	#メール送信
  	@new_reservation = Reservation.new(reservation_params)
  	@new_reservation.save
  	#ContactMailer.received_email(@new_reservation).deliver
  	render :action => 'create'
  end

  private
  	def reservation_params
  		params.require(:reservation).permit(:name,:email,:day,:time,:member,:content,:staff_id)
  	end

end
