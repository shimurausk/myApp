class ContactsController < ApplicationController
	def index
		@contact = Contact.new
		render :action => 'index'
	end

	def confirm
		@contact = Contact.new(contact_params)

		if @contact.valid?
			render :action => 'confirm'
		else
			render :action => 'index'
		end
	end

	def create
		@contact = Contact.new(contact_params)
		#NoticeMailer.received_email(@contact).deliver
		render :action => 'create'
	end

	private
		def contact_params
			params.require(:contact).permit(:name,:email,:genre,:message)
		end
end
