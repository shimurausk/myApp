class StaffsController < ApplicationController

	def index
		if user_signed_in?
		@staffs = Staff.all
		else	
		redirect_to '/'
		end
	end

	def show
		@staff = Staff.find(params[:id])
	end
end
