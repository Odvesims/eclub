require 'rubygems'
require 'json'
require 'net/http'
require 'date'
 
class CambiodatasController < ActionController::Base 
  respond_to :json 
	def index
		cambio_data = Cambiodata.first	
		
		el_jason = Array.new
		
		controles = {}
		deboxionales_arr = Array.new
		hash = {}
		hash["cambio_data"] = cambio_data.si_no	
		hash["version"] = cambio_data.version_data
		deboxionales_arr.push(hash)
		controles["cambio_data"] = deboxionales_arr
		el_jason.push(controles)
		JSON.generate(controles) 
		render :text => JSON.generate(controles)
	end
  
	def show
		cambio_data = Cambiodata.first	
		el_jason = Array.new
		
		hash = {}
		hash["cambio_data"] = cambio_data.si_no
		hash["version"] = cambio_data.version_data
		el_jason.push(hash)
		JSON.generate(el_jason) 
		render :text => JSON.generate(el_jason)
	end
	
	def create
	end
end
