class SessionsController < ApplicationController
	def new
		$selected_theme = "sunny"
	end

	def create
		#jfb user = User.find_by_email(params[:session][:email].downcase)
		user = User.find_by_login(params[:session][:login].downcase)
		if user && user.authenticate(params[:session][:password]) 
			if user.remember_token.to_i == 0
				token = SecureRandom.urlsafe_base64
				user.remember_token = Digest::SHA1.hexdigest(token.to_s)
				user.save
			end
			sign_in user
			#buscar nombre del consorcio
			cookies[:central_name] = 'eclub_api'
			redirect_to root_url
			#redirect_back_or user
		else
			flash.now[:error] = "Combinacion de usuario/clave invalida"
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to root_url
	end
end
