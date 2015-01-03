class ReservationsController < ApplicationController

	def index
		@reservations = Reservation.all

		@reservation_list = []

		@reservations.each do |reservation|
#binding.pry
			@end = Time.zone.local(reservation.day.year,
														 reservation.day.month,
														 reservation.day.day,
														 reservation.day.hour+reservation.time.hour,
														 reservation.time.min
														)
					
			@reservation_data = {
								'id' => reservation.id,
								'title' => '○',
								'start' => reservation.day.strftime("%Y-%m-%d %H:%M:%S"),
								'end' => @end.strftime("%Y-%m-%d %H:%M:%S"),
								'backgroundColor' => '#fc0',
								'borderColor' => '#fc3'
							}
			@reservation_list.push(@reservation_data)
			
		end

		@new_reservation = Reservation.new

	end

	def show
		@reservation = Reservation.find(params[:id])

		#@reservation_list = []
#binding.pry	
		#@reservations.each do |reservation|
		@end = Time.zone.local(@reservation.day.year,@reservation.day.month,@reservation.day.day,@reservation.day.hour+@reservation.time.hour,@reservation.time.min)
			
		@reservation_data = {
							'title' => '○',
							'start' => @reservation.day.strftime("%Y-%m-%d %H:%M:%S"),
							'end' => @end.strftime("%Y-%m-%d %H:%M:%S"),
							'backgroundColor' => '#fc0',
							'borderColor' => '#fc3'
						}

			#@reservation_list.push(@reservation_data)
		#end
	#binding.pry
	end

	def list
		@reservations = Reservation.where(:day=>"2014-12-27")
	end

	def confirm

  		# @year = reservation_params['day(1i)']
  		# @month = reservation_params['day(2i)']
  		# @day = reservation_params['day(3i)']
  		# @hour = reservation_params['time(4i)']
  		# @min = reservation_params['time(5i)']


  		# reservation_params['day(4i)'].replace(@hour)
  		# reservation_params['day(5i)'].replace(@min)
  		# reservation_params['time(1i)'].replace(@year)
  		# reservation_params['time(2i)'].replace(@month)
  		# reservation_params['time(3i)'].replace(@day)


  	#入力チェック
  	@reservation = Reservation.new(reservation_params)
  	if @reservation.valid?



  		render :action => 'confirm'

#binding.pry
  		
  	else
  		render :action => 'index'
  	end

  end

  def thanks
  	#メール送信
  	@reservation = Reservation.new(reservation_params)
  	@reservation.save
  	#ContactMailer.received_email(@reservation).deliver
  	render :action => 'thanks'
  end

  private
  	def reservation_params
  		params.require(:reservation).permit(:name,:email,:day,:time,:member,:content)
  	end

end
