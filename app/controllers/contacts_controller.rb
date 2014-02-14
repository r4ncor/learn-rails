class ContactsController < ApplicationController
	# def process_form
	# 	if params[:contact][:name].blank?
	# 		raise 'Name is blank!'
	# 	end
	# 	if params[:contact][:email].blank?
	# 		raise 'Email is blank!'
	# 	end
	# 	if params[:contact][:content].blank?
	# 		raise 'Message is blank!'
	# 	end

	# 	Rails.logger.debug "DEBUG: params are #{params}"
	# 	flash[:notice] = "Received request from #{params[:contact][:name]}"
	# 	redirect_to root_path
	# end

	def new
		@contact = Contact.new
	end
	def create
		@contact = Contact.new(secure_params)
		if @contact.valid?
			@contact.update_spreadsheet
			# TODO save data
			# TODO send message
			Rails.logger.debug "DEBUG: params are #{params}"
			flash[:notice] = "Message sent from #{@contact.name}."
			redirect_to root_path
		else
			render :new
		end
	end

	private
	def secure_params
		params.require(:contact).permit(:name, :email, :content)
	end

end