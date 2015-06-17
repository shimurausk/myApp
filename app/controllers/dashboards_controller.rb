class DashboardsController < ApplicationController

include ApplicationHelper

	def index
		setUser(current_user.username)
		workList

		@blogs = Blog.all
	end

	def show
		@staff_data = User.find(params[:id]).staff
		workList
	end

	def new
		@new_work = Work.new
		halfMonth
		@bisnesstime = ApplicationHelper::STAFF_START_TIME..ApplicationHelper::STAFF_END_TIME
	end

	def workday
		@new_work = Work.new
		@new_work.date = params[:workday]
		
		@worktimes = []
		num = 0

		while num < ApplicationHelper::STAFF_END_TIME-ApplicationHelper::STAFF_START_TIME do
			@worktimes.push([ApplicationHelper::STAFF_START_TIME+num,@new_work.date+(ApplicationHelper::STAFF_START_TIME+num).hour])
			num = num+1
		end
	end	

	def confirm
		works = work_params
		@works =[]

		works.each do |w|

			work = Work.new(w)
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

		@works =[]

		work_params.each do |w|
			unless w[:start].empty?
				work = Work.new(w)
				@works.push(work)
			end
		end

		@works.each do |w|
			if w.valid?
				w.save
			end
		end
		
		#メール送信
  	#ContactMailer.received_email(@new_reservation).deliver
		render :action => 'create'
	end

	def edit

		if User.find(params[:id]).staff.present?
			@staff_data = User.find(params[:id]).staff
		else 
			redirect_to '/dashboards'
		end

		@staff_reservations = Reservation.where(:staff_id=>@staff_data[:id])

	end

	def update
		
		if Staff.find(params[:staff][:id]).present?
			@staff_update = Staff.find(params[:staff][:id])
		else 
			redirect_to '/dashboards'
		end

		if @staff_update.update(staff_params)
			redirect_to dashboard_path
		else
			render "dashboards/edit"
		end
	end

	def destroy

		if Blog.find(params[:id]).present?
			@blog = Blog.find(params[:id])
		else 
			redirect_to '/dashboards'
		end
		
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
		
		def work_params
			params.require(:work).map do |param|
				ActionController::Parameters.new(param.to_hash).permit(:date,:start,:end,:break,:staff_id)
			end
		end
end
