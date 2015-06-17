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

	def new
		@new_reservation = Reservation.new

		#営業終了時間より後ろの時間で検索したとき
		if params[:daytime]>ApplicationHelper::STORE_END_TIME.to_s || params[:daytime]<ApplicationHelper::STORE_START_TIME.to_s
			this_daytime = Time.zone.parse(params[:reservation][:day]).beginning_of_day+ApplicationHelper::STORE_START_TIME.hours
		else
			this_daytime = Time.zone.parse(params[:reservation][:day]).beginning_of_day+(params[:daytime].to_i).hours
		end

		@new_reservation.day = this_daytime.to_s

		#todaysReservation(this_daytime.to_s)

		setStaff()
		#setTime()
		reservationCheck()
		setMember()
		setContent()
	end

  def create
  	@new_reservation = Reservation.new(reservation_params)
  	
  	if @new_reservation.save
    	render :action => 'create'
    else
    	render 'confirm'
    end

  	#ContactMailer.received_email(@new_reservation).deliver
  	
  end

	def update
		@new_reservation = Reservation.find(params[:id])
		@params = reservation_params

		if @new_reservation.update(@params)
    	redirect_to '/staffs'
    else
    	render 'edit'
    end

	end

	def edit

	end

	def destroy

		if params[:id].present?
			@reservation = Reservation.find(params[:id])
			@reservation.destroy
			redirect_to '/staffs'
		else
			redirect_to '/staffs'
		end

	end

	def list
		this_day = params[:day].to_time

		#カレンダーをクリックしたとき
		if this_day.strftime('%H')<ApplicationHelper::STORE_START_TIME.to_s
			this_day = this_day.beginning_of_day+ApplicationHelper::STORE_START_TIME.hours
		end

		#reservationCheck(params[:day])
		searchReservation(this_day)

		# if params[:day].match(/:/)
		# 	search_time =  Time.zone.parse(params[:day])
		# 	unless @search_reservation.include?(search_time.strftime('%H').to_i)
		# 		@not_reservation_text = "申し訳ございません。満席となっております。"
		# 	end
		# end

		allReservation
		@new_reservation = Reservation.new
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
	  	@staff_name = Staff.find_by(id: @new_reservation.staff_id).try(:name)
	  end

  	if @new_reservation.valid?
  		render :action => 'confirm'
  	else
  		render :action => 'new'
  	end

  end

  private
  	def reservation_params
  		params.require(:reservation).permit(:name,:email,:day,:time,:member,:content,:staff_id)
  	end

end
