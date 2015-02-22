class StaffsController < ApplicationController

	def index
		if user_signed_in?
		@staffs = Staff.all
		 
		@works_json =[]
		@staffs.each do |staff|
			staff.works.each do |work|
			@work_data = {
								'title' => staff.name,
								'start' => work.start.strftime("%Y-%m-%d %H:%M:%S"),
								'end' => work.end.strftime("%Y-%m-%d %H:%M:%S"),
								#'backgroundColor' => '#fc0',
								#'borderColor' => '#fc3',
								'img' => staff.icon.url
							}
			@works_json.push(@work_data)
			
			end
		end
		else	
		redirect_to '/'
		end
	end

	def show
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
end
