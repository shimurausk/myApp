class StaffsController < ApplicationController

	def index
		if user_signed_in?
			@staffs = Staff.all
			@reservations = Reservation.all

			@new_work = Staff.new()
			@new_reservation = Reservation.new()
			
			@works_json =[]
			@reservations_json =[]

			@staffs.each do |staff|
				staff.works.each do |work|
				@work_data = {
				          'label' => 'staff',	
									'title' => staff.name,
									'start' => work.start.strftime("%Y-%m-%d %H:%M:%S"),
									'end' => work.end.strftime("%Y-%m-%d %H:%M:%S"),
									'backgroundColor' => '#fc0',
									'borderColor' => '#fc3',
									'img' => staff.icon.url,
									'work_id' => work.id,
									'work_staff_id' => work.staff_id,
									'work_start' => work.start,
									'work_end' => work.end
								}
				@works_json.push(@work_data)
				
				end
			end

			@reservations.each do |r|
				title = r.member.to_s+'人'
				popup = r.name+' '+r.content
				@r_data = {
					        'label' => 'reservation',
									'title' => title,
									'popup' => popup,
									'start' => r.day.strftime("%Y-%m-%d %H:%M:%S"),
									'end' => r.time.strftime("%Y-%m-%d %H:%M:%S"),
									'reservation_id' => r.id,
									'reservation_time' => r.time,
									'reservation_member' => r.member,
									'reservation_content' => r.content
								}
				@works_json.push(@r_data)

			end

		else	
			redirect_to '/'
		end
	end

	def show
		#nilなるかも
		@staff = Staff.find(params[:id])

		@works_json =[]
			@staff.works.each do |work|
			@work_data = {
								'title' => @staff.name,
								'start' => work.start.strftime("%Y-%m-%d %H:%M:%S"),
								'end' => work.end.strftime("%Y-%m-%d %H:%M:%S"),
								'img' => @staff.icon.url,
								'backgroundColor' => '#fc0',
								'borderColor' => '#fc3'
							}
			@works_json.push(@work_data)

			end
	end

	def edit
		@staff = Staff.find(params[:id])
	end

	def update
		#@newを変える
    if params[:staff].present?
    	@new = Staff.find(params[:id])
    	@params = staff_params
    else
    	@new = Work.find(params[:work][:id])
    	@params = work_params
    end
		
    if @new.update(@params)
    	redirect_to '/staffs'
    else
    	render 'edit'
    end
	end

	def destroy
		#nilなるかも
		@staff = Staff.find(params[:id])
		@staff.destroy
		redirect_to staffs_path
	end

	private
	  def staff_params
	  	params.require(:staff).permit(:name,:icon,:email,:address,:age,:post,:memo,:hourlywage)
	  end
	  def work_params
	  	params.require(:work).permit(:date,:start,:end,:id,:staff_id)
	  end
end
