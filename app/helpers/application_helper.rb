module ApplicationHelper

	def tag_cloud(tags, classes)

		max = tags.sort_by(&:count).last

		tags.each do |tag|
							#binding.pry
			index = tag.count.to_f / max.count * (classes.size-1)

			yield(tag,classes[index.round])
		end
	end

	def businessHours(startTime, endTime)
		keys = (startTime..endTime).to_a
		values = (startTime..endTime).to_a
		transposed = [keys, values].transpose
		@businessHours = Hash[transposed]
	end

	def setTime
		@time = []
		num = 1

		if @new_reservation[:day].nil? 
			@new_reservation[:day] = Date.today
		end

		# @dc = Reservation.where(:day => @new_reservation.day.strftime('%Y-%m-%d')..(@new_reservation.day+1.day).strftime('%Y-%m-%d'))
		#binding.pry

		# checktimes = []
		# @dc.each do |f|
		# 	if f.day-params[:reservation][:day].to_time+params[:daytime].to_i.hours > 0
		# 		checktimes.push(f.day.strftime('%H:%M'))
		# 	end

		# 	checktimes.sort

		# end
		#予約できる時間を割り出す
		#その日時の予約をとって、次の予約までの時間帯を表示

		while num <= 8 do
			@time.push([num,@new_reservation[:day]+num.hour])
			num = num +1
		end
	end

	def setMember
		@member = []
		num = 1
		while num<= 5 do
			@member.push([num,num])
			num = num +1
		end
	end

	def setStaff
		@staffs = []
		@allstaff = Staff.all
		
		@allstaff.each do |staff|
			
			@staffs.push([staff[:name],staff[:id]])
		end
		
	end

	def setContent
		@content = ["カット", "カット"], ["パーマ", "パーマ"]

		@reservations = Reservation.all
		@course_a = 0
		@course_b = 0
		@reservations.each do |reservation|
			if reservation.content  == 'コースA'
				@course_a = @course_a +1
			end
			if reservation.content  == 'コースB'
				@course_b = @course_b +1
			end
		end

		#電話で予約取る場合もあり。少しバッファを持たせた方がいい
		if @course_a < 3
			@content.push(["コースA", "コースA"])
		end
		if @course_b < 3
			@content.push(["コースB", "コースB"])
		end

	end

end
