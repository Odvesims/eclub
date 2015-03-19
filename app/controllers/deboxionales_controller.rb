require 'rubygems'
require 'json'
require 'net/http'
 
class DeboxionalesController < ActionController::Base
 
  respond_to :json
 
  def index
	deboxionales = Deboxional.all	
	
	hash = [
		deboxionales.each do |deb|
			{"id" => "#{deb.id}",
			"fecha_dia" => "#{deb.fecha_dia}",
			"titulo" => "#{deb.titulo}",
			"versiculo" => "#{deb.versiculo}",
			"cita" => "#{deb.cita}",
			"cuerpo" => "#{deb.cuerpo}",
			"autor" => "#{deb.autor}",
			"dia" => "#{deb.dia}",
			"anio" => "#{deb.anio}",
			"fecha" => "#{deb.fecha}"}
	end
	]	
	puts hash.to_s
	#puts hash.to_a.to_s.gsub("#<Deboxional", "{").gsub(">", "}")
    #response = Net::HTTP.get_response(URI.parse($usaGovURI))
    #data = response.body
    JSON.parse([hash.to_a.to_s.gsub("#<Deboxional", "{").gsub(">", "}")].to_json)
 
    render :text => JSON.parse([hash.to_a.to_s.gsub("#<Deboxional", "{").gsub(">", "}")].to_json)
  end
  
  def show
	dia = params[:dia].to_i
	year = params[:year]
	puts dia
	if dia > 0
		deboxionales = Deboxional.where("dia = #{dia} AND anio = '#{year}'")
	else	
		deboxionales = Deboxional.all
	end
	if deboxionales == nil
		hash = [[[]]]
	else
		deboxionales.each do |deb|		
		hash =[ 
				JSON["id" => "#{deb.id}",
				"fecha_dia" => "#{deb.fecha_dia}",
				"titulo" => "#{deb.titulo}",
				"versiculo" => "#{deb.versiculo}",
				"cita" => "#{deb.cita}",
				"cuerpo" => "#{deb.cuerpo}",
				"autor" => "#{deb.autor}",
				"dia" => "#{deb.dia}",
				"anio" => "#{deb.anio}",
				"fecha" => "#{deb.fecha}"]]
		end
		puts hash.to_s
		el_json = JSON ['test' => 20, 'id' => 1, 'dia' => 20]
		#puts hash.to_a.to_s.gsub("#<Deboxional", "{").gsub(">", "}")
		#response = Net::HTTP.get_response(URI.parse($usaGovURI))
		#data = response.body
		JSON.parse(hash.to_json)
	 
		render :text => JSON.parse(hash.to_a.to_json)
	end
  end
end
