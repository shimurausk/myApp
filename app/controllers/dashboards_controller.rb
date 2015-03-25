class DashboardsController < ApplicationController

include ApplicationHelper

	def index
		setUser(current_user.username)
		@works = Work.where(:staff_id => current_user.staff[:id])
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
		#@blog = Blog.find(params[:id])
	end

	def new
		#@blog = Blog.new
		@new_work = Work.new
		halfMonth
		
	end

	def workday
		@new_work = Work.new
		@new_work.date = params[:workday]
		
		@worktimes = []

		while STAFF_START_TIME<=STAFF_END_TIME do
			@worktimes.push([STAFF_START_TIME,@new_work.date+STAFF_START_TIME.hour])
			STAFF_START_TIME = STAFF_START_TIME+1
		end
	end	

	def confirm
		works = work_params
		@works =[]

		works.each do |w|

			work = Work.new(w)
			#work.valid?
			@works.push(work)
		end

  	halfMonth

  	#if @works.valid?
  		render :action => 'confirm'
  	# else
  	# 	@new_work = @works
  	# 	render :action => 'new'
  	# end
	end

	def create
		# @blog = Blog.new(blogs_params)
		# if @blog.save
		# 	redirect_to @blog
		# else
		# 	render 'new'
		# end

		works = work_params
		@works =[]

		works.each do |w|
			unless w[:start].empty?
				work = Work.new(w)
				@works.push(work)
			end
		end

		#@works = Work.new(work_params)
		#if @works.save
			#メール送信
	  	# @works = Work.new(work_params)
	  	# @works.save
	  	#ContactMailer.received_email(@new_reservation).deliver
	  	render :action => 'create'
		#else
		#	render 'new'
		#end	

	end

	def edit
		#@blog = Blog.find(params[:id])
		@staff_info = User.find(params[:id]).staff
		@staff_reservations = Reservation.where(:staff_id=>@staff_info[:id])
	end

	def update
		#@blog = Blog.find(params[:id])

		# if @blog.update(blogs_params)
		# 	redirect_to @blog
		# else
		# 	render "edit"
		# end

		@staff_update = Staff.find(params[:staff][:id])
		if @staff_update.update(staff_params)
			redirect_to dashboard_path
		else
			render "dashboards/edit"
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

		def staff_params
			params.require(:staff).permit(:name,:email,:address,:age,:hourlywage)	
		end

		# def work_params
		# 	params.require(:work).permit(:date,:start,:end,:break,:staff_id)
		# end

		
		def work_params
			params.require(:work).map do |param|
				ActionController::Parameters.new(param.to_hash).permit(:date,:start,:end,:break,:staff_id)
			end
		end
end
