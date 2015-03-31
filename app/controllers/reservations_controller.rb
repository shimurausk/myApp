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

		todaysReservation(params[:day])
		@todays_reservation.sort!

		#予約が入っていない時間を返す
		@yet_reservation_time = {}
		@business_hours = (STORE_START_TIME...STORE_END_TIME).to_a

		@business_hours.each do |hour|
			if @todays_reservation.nil?
				@yet_reservation_time[hour] = '○'			
			else 
				@yet_reservation_time[hour] = @todays_reservation.index(hour) ? 'X' : '○'
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

  	#入力チェック
  	@new_reservation = Reservation.new(reservation_params)

  	setStaff()
  	setTime()
  	setMember()
  	setContent()
  		@staff_name = Staff.all[@new_reservation.staff_id][:name]
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
