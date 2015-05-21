module ApplicationHelper

	STORE_START_TIME = 10
	STORE_END_TIME = 20

	STAFF_START_TIME = STORE_START_TIME-1
	STAFF_END_TIME = STORE_END_TIME-1

	MAX_SEATS = 2

	def tag_cloud(tags, classes)

		max = tags.sort_by(&:count).last

		tags.each do |tag|
							
			index = tag.count.to_f / Integer(max.count) * (classes.size-1)

			yield(tag,classes[index.round])
		end
	end

	def markdown(text)
    unless @markdown
      renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true)
      options = {
      	tables: true
      	# autolink: true,
	      # no_intra_emphasis: true,
	      # fenced_code_blocks: true,
	      # lax_html_blocks: true,
	      # strikethrough: true,
	      # superscript: true
      }
      @markdown = Redcarpet::Markdown.new(renderer,options)
    end

    @markdown.render(text).html_safe
  end

  def all_category
  	@all_category = []
  	(@blogs = Blog.all).each do |blog|
  		@all_category.push([blog.category,blog.category])
  	end
  	@all_category.uniq!
  end

  def all_tag
  	@all_tag = []
  	(@blogs = Blog.all).each do |blog|
  		(tags = blog.tags).each do |tag|
	  		@all_tag.push([tag.name,tag.name])
	  	end
  	end
  	@all_tag.uniq!
  end

	def businessHours
		@business_hours = (STORE_START_TIME..STORE_END_TIME).to_a
		values = (STORE_START_TIME..STORE_END_TIME).to_a
		transposed = [keys, values].transpose
		@business_hours = Hash[transposed]
	end

	def halfMonth
		today = Time.zone.now

		#1--14,15--30(28.31)
		if today<today.beginning_of_month+2.week
			startday = today.beginning_of_month
			endday = today.beginning_of_month+2.week
		else
			startday = today.beginning_of_month+2.week
			endday = today.end_of_month
		end

		@days = []

		num = 0

		(startday.strftime('%d').to_i..endday.strftime('%d').to_i).each do |n|			
			@days.push(startday+num.day)
			num += 1
		end

	end

	def workList
		@works = Work.where(:staff_id => current_user.staff[:id])
		@work_list = []

		@works.each do |work|

			@start_end = work.start.strftime("%H:%M")+'-'+work.end.strftime("%H:%M")
					
			@work_data = {
								'id' => work.id,
								'title' => @start_end,
								'start' => work.date.strftime("%Y-%m-%d %H:%M:%S"),
								'end' => work.date.strftime("%Y-%m-%d %H:%M:%S"),
								'backgroundColor' => '#fc0',
								'borderColor' => '#fc0',
								'textColor' => '#fff'
							}
							
			@work_list.push(@work_data)
			
		end
	end	

	def allReservation
		
		@reservations = Reservation.all
		@all_reservation = []

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

			@all_reservation.push(@reservation_data)
		end

	end

	def todaysReservation(day)
		@todays_reservation = []

		from = Time.zone.parse(day)+(STORE_START_TIME.hours)
		to = from+1.day

		if Reservation.where(day: from...to).any?
			@get_reservations = Reservation.where(day: from...to).order("day")
			#binding.pry
			@get_reservations.each do |reservation|
				reserved_time = 0
				while reserved_time <= reservation.time.strftime("%H").to_i-reservation.day.strftime("%H").to_i do
					# if @ticket < MAX_SEATS
							@todays_reservation.push(reservation.day.strftime("%H").to_i+reserved_time)
							reserved_time = reserved_time +1
					# end
				end
				# @ticket = @ticket+1
			end
		end

	end

	def searchReservation(params_day)
		@search_reservation = []
		@exist_reservations =[]

		today = Time.zone.parse(params_day).beginning_of_day

		@business_hours = (STORE_START_TIME...STORE_END_TIME).to_a

		@business_hours.each do |this_time|

			#既存予約時間の終了チェック
			@exist_reservations.each do |reservation|
				if reservation.time.strftime('%H').to_i <= this_time
					@exist_reservations.delete(reservation)
				end
			end
	
			if @exist_reservations.length < MAX_SEATS

				#1時間づつチェック
				this_time_reservations = Reservation.where(day: today+this_time.hours...today+(this_time+1).hours)

				if this_time_reservations.order("day").any?
					
					this_time_reservations.each do |r|

						@exist_reservations.push(r)

						if @exist_reservations.length < MAX_SEATS
							@search_reservation.push(this_time)
						else
								if @search_reservation.include?(this_time)
									@search_reservation.delete_at(@search_reservation.index(this_time))
								end
						end							
					end

				else
					@search_reservation.push(this_time)
				end

			end
		end
	end

	def setTime
		@time = []

		if @new_reservation.day.nil? 
			@new_reservation.day = Date.today
		end

		#予約できる時間を割り出す
		#その日時の予約をとって、次の予約までの時間帯を表示

		num = 0

		if @todays_reservation.present?

			#選択した時間がすでに予約されている時間より後か
			if @todays_reservation.sort.select{|x| x > params[:daytime].to_i}[0].nil?

				# 選択時間が予約時間より後の場合は営業終了時間までを表示
				while num < (STORE_END_TIME.to_i)-(params[:daytime].to_i) do
					@time.push([num+1,@new_reservation.day+(num+1).hour])
					num = num +1
				end

			else	

				#選択した日付 params[:daytime]
				#今日の予約を取得
				#予約可能な時間までを取得
binding.pry
				next_reservation_time = @todays_reservation.sort.select{|x| x > params[:daytime].to_i}[0]
				while num < next_reservation_time-params[:daytime].to_i do
					@time.push([num+1,@new_reservation.day+(num+1).hour])
					num = num +1
				end

			end
		else 
				#予約がはいっていない　日付が決まってない場合 営業終了時間までを表示 page/index reservation/index
				if params[:daytime].to_i.nil?
					params[:daytime] = STORE_START_TIME.to_i
				end

				while num < (STORE_END_TIME.to_i)-(params[:daytime].to_i) do
					@time.push([num+1,@new_reservation.day+(num+1).hour])
					num = num +1
				end
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

	def setUser(username)
		@this_user = {}
		alluser = User.all
		
		@this_user = Staff.where(:name=>username)
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
