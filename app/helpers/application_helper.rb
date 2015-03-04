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

		if @course_a < 3
			@content.push(["コースA", "コースA"])
		end
		if @course_b < 3
			@content.push(["コースB", "コースB"])
		end

	end

end
