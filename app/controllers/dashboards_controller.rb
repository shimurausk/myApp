class DashboardsController < ApplicationController

	def index
		@works = Work.where(:staff_id => current_user.id)
		@works_list = []

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
			@works_list.push(@work_data)
			
		end
	end

	def show
		@blog = Blog.find(params[:id])
	end

	def new
		#@blog = Blog.new
		@new_work = Work.new

		today = Time.now
		startday = today<today.beginning_of_month+2.week ? today.beginning_of_month : today.beginning_of_month+2.week

		#@days = ['2015-04-12',['2015-04-12 10:00','2015-04-12 11:00']]
		@days = []

		num = 0

		while num<=(today.beginning_of_month+2.week).strftime('%d').to_i do			
			@days.push(startday+num.day)
			num = num +1
		end
		
	end

	def workday
		@new_work = Work.new
		@new_work.date = params[:workday]
		
		@worktimes = []
		stime = 10
		etime = 22

		while stime<=etime do
			@worktimes.push([stime,@new_work.date+stime.hour])
			stime = stime +1
		end
	end	

	def confirm
  	@works = Work.new(work_params)
  		
  	if @works.valid?
  		render :action => 'confirm'
  	else
  		@new_work = @works
  		render :action => 'new'
  	end
	end

	def create
		# @blog = Blog.new(blogs_params)
		# if @blog.save
		# 	redirect_to @blog
		# else
		# 	render 'new'
		# end

		@works = Work.new(work_params)
		if @works.save
			#メール送信
	  	# @works = Work.new(work_params)
	  	# @works.save
	  	#ContactMailer.received_email(@new_reservation).deliver
	  	render :action => 'create'
		else
			render 'new'
		end	

	end

	def edit
		@blog = Blog.find(params[:id])
	end

	def update
		@blog = Blog.find(params[:id])

		if @blog.update(blogs_params)
			redirect_to @blog
		else
			render "edit"
		end
	end

	def destroy
		@blog = Blog.find(params[:id])

		@blog.destroy
		redirect_to blogs_path
	end

	 private
		def blogs_params
			params.require(:blog).permit(:title,:text,:avatar,:tag_list)	
		end
		def work_params
			params.require(:work).permit(:date,:start,:end,:break,:staff_id)
		end	
end
