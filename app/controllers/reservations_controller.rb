class ReservationsController < ApplicationController

include ApplicationHelper

	def index
		@reservations = Reservation.all

		@reservation_list = []

		@reservations.each do |reservation|

			@start_end = reservation.day.strftime("%H:%M")+'-'+reservation.time.strftime("%H:%M")
					
			@reservation_data = {
								'id' => reservation.id,
								'title' => @start_end,
								'start' => reservation.day.strftime("%Y-%m-%d %H:%M:%S"),
								'end' => reservation.time.strftime("%Y-%m-%d %H:%M:%S"),
								'backgroundColor' => '#aaa',
								'borderColor' => '#aaa',
								'textColor' => '#fff'
							}
			@reservation_list.push(@reservation_data)
			
		end

		@new_reservation = Reservation.new

		setTime()
  	setMember()
  	setContent()

	end

	def show
		# @reservation = Reservation.find(params[:id])

		# @reservation_list = []
		#@reservations.each do |reservation|
		# @end = Time.zone.local(@reservation.day.year,@reservation.day.month,@reservation.day.day,@reservation.day.hour+@reservation.time.hour,@reservation.time.min)
			
		# @reservation_data = {
		# 					'title' => 'X',
		# 					'start' => @reservation.day.strftime("%Y-%m-%d %H:%M:%S"),
		# 					'end' => @end.strftime("%Y-%m-%d %H:%M:%S"),
		# 					'backgroundColor' => '#aaa',
		# 					'borderColor' => '#aaa',
		# 					'textColor' => '#ccc'
		# 				}

		# 	@reservation_list.push(@reservation_data)
		#end
	end

	def list
		from = Time.zone.parse(params[:day])
		to = Time.zone.parse((from + 1.day).strftime("%Y-%m-%d"))

		if Reservation.where(day: from...to).length > 0
			@todaysReservations = Reservation.where(day: from...to)
			@re = []
			@todaysReservations.each do |todaysReservation|
				num = 0
				while num <= todaysReservation.time.strftime("%H").to_i-todaysReservation.day.strftime("%H").to_i do
					@re.push(todaysReservation.day.strftime("%H").to_i+num)
					num = num +1
				end
			end
		end

		@reservation_today = {}

		@businessHours = (10..20).to_a

		@businessHours.each do |hour|
			if @re.nil?
				@reservation_today[hour] = '○'			
			else 
				@reservation_today[hour] = @re.index(hour) ? 'X' : '○'
			end
		end	

		@reservations = Reservation.all
		@reservation_list = []

		@reservations.each do |reservation|

			@start_end = reservation.day.strftime("%H:%M")+'-'+reservation.time.strftime("%H:%M")
					
			@reservation_data = {
								'id' => reservation.id,
								'title' => @start_end,
								'start' => reservation.day.strftime("%Y-%m-%d %H:%M:%S"),
								'end' => reservation.time.strftime("%Y-%m-%d %H:%M:%S"),
								'backgroundColor' => '#aaa',
								'borderColor' => '#aaa',
								'textColor' => '#ccc'
							}
			@reservation_list.push(@reservation_data)
		end
		@new_reservation = Reservation.new
	end


	def new
		@new_reservation = Reservation.new

		@new_reservation[:day] = params[:reservation][:day] + ' ' + params[:daytime]

		setStaff()
		setTime()
		setMember()
		setContent()
	end

	def confirm

		# @year = reservation_params['day(1i)']
		# @month = reservation_params['day(2i)']
		# @day = reservation_params['day(3i)']
		# @hour = reservation_params['day(4i)']
		# @min = reservation_params['day(5i)']

		
		# reservation_params['day(4i)'].replace(@hour)
		# reservation_params['day(5i)'].replace(@min)
		# reservation_params['time(1i)'].replace(@year)
		# reservation_params['time(2i)'].replace(@month)
		# reservation_params['time(3i)'].replace(@day)

		# @date = reservation_params[:day].to_time.to_i
		# @time = reservation_params[:time].to_i*60*60
		# reservation_params[:time] = Time.at(@date+@time)
			
			#日時がすでにあればエラー
		#if Reservation.where("day<?",params[:day])



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
