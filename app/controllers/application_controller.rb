class ApplicationController < ActionController::Base
	#protect_from_forgery
	include SessionsHelper
	#include ActiveDevice
	#skip_before_filter :set_mobile_format
	# Force signout to prevent CSRF attacks
	def handle_unverified_request
		sign_out
		super
	end
end
