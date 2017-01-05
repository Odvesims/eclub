require 'rubygems'
require 'json'
require 'net/http'
require 'date'
 
class DataversionController < ActionController::Base 
  respond_to :json 
	def index
		cambio_data = Cambiodata.first
		controles = {}
		controles["year"] = cambio_data.year.to_i
		controles["update_date"] = cambio_data.update_date
		controles["version"] = cambio_data.version_data
		JSON.generate(controles) 
		render :text => JSON.generate(controles)
	end
  
	def show
		cambio_data = Cambiodata.first
		controles = {}
		controles["year"] = cambio_data.year.to_i
		controles["update_date"] = cambio_data.update_date
		controles["version"] = cambio_data.version_data
		JSON.generate(controles) 
		render :text => JSON.generate(controles)
	end
end
