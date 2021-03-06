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
		
		if Staff.find_by_id(params[:id]).present?
			@staff = Staff.find_by_id(params[:id])
		else 
			redirect_to '/staffs'
		end

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
		if Staff.find_by_id(params[:id]).present?
			@staff = Staff.find_by_id(params[:id])
		else 
			redirect_to '/staffs'
		end
	end

	def update
    if params[:staff].present?
    	@new_staff = Staff.find(params[:id])
    	@params = staff_params
    else
    	@new_staff = Work.find(params[:work][:id])
    	@params = work_params
    end
		
    if @new_staff.update(@params)
    	redirect_to '/staffs'
    else
    	render 'edit'
    end
	end

	def destroy
		if params[:staff].present?
    	@staff = Staff.find(params[:id])
    	@params = staff_params
    else
    	@staff = Work.find(params[:work][:id])
    	@params = work_params
    end

    if @staff.destroy
    	redirect_to '/staffs'
    else
    	redirect_to staffs_path
    end

	end

	private
	  def staff_params
	  	params.require(:staff).permit(:name,:icon,:email,:address,:age,:post,:memo,:hourlywage)
	  end
	  def work_params
	  	params.require(:work).permit(:date,:start,:end,:id,:staff_id)
	  end
end
