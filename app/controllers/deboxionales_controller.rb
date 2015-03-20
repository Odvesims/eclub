require 'rubygems'
require 'json'
require 'net/http'
 
class DeboxionalesController < ActionController::Base 
  respond_to :json 
	def index
		deboxionales = Deboxional.all
			el_jason = Array.new
			deboxionales.each do |deb|	
				hash = {}
				hash["id"] = deb.id	
				hash["fecha_dia"] = deb.fecha_dia
				hash["titulo"] = deb.titulo
				hash["versiculo"] = deb.versiculo
				hash["cita"] = deb.cita
				hash["cuerpo"] = deb.cuerpo
				hash["autor"] = deb.autor
				hash["dia"] = deb.dia
				hash["anio"] = deb.anio
				hash["fecha"] = deb.fecha
				el_jason.push(hash)
			end
		JSON.generate(el_jason) 
		render :text => JSON.generate(el_jason)
	end
	
	def update
		dia = params[:dia].to_i
		year = params[:year]
		day = dia + 1
		puts day;
		deboxionales = Deboxional.where("dia > #{dia.to_i + 1} AND anio = '#{year}'").all
			el_jason = Array.new
			deboxionales.each do |deb|	
				hash = {}
				hash["id"] = deb.id	
				hash["fecha_dia"] = deb.fecha_dia
				hash["titulo"] = deb.titulo
				hash["versiculo"] = deb.versiculo
				hash["cita"] = deb.cita
				hash["cuerpo"] = deb.cuerpo
				hash["autor"] = deb.autor
				hash["dia"] = deb.dia
				hash["anio"] = deb.anio
				hash["fecha"] = deb.fecha
				el_jason.push(hash)
			end
		JSON.generate(el_jason) 
		render :text => JSON.generate(el_jason)	
	end
  
	def show
		dia = params[:dia].to_i
		year = params[:year]
		configuraciones = Configuracione.first	
		if dia > 0	
			if configuraciones.modalidad == "anual"
				deboxionales = Deboxional.where("dia > #{dia} AND anio = '#{year}'").all
			elsif configuraciones.modalidad == "semanal"
				deboxionales = Deboxional.where("dia >= #{dia}  AND dia <= #{dia} + 7 AND anio = '#{year}'").all
			elsif configuraciones.modalidad == "uno"
				deboxionales = Deboxional.where("dia = #{dia} AND anio = '#{year}'").all
			end
		else	
			deboxionales = Deboxional.all
		end
		
		el_jason = Array.new
		
		if deboxionales == nil	
			hash = [[[]]]
			el_jason.push(hash)
		else
			deboxionales.each do |deb|	
				hash = {}
				hash["id"] = deb.id	
				hash["fecha_dia"] = deb.fecha_dia
				hash["titulo"] = deb.titulo
				hash["versiculo"] = deb.versiculo
				hash["cita"] = deb.cita
				hash["cuerpo"] = deb.cuerpo
				hash["autor"] = deb.autor
				hash["dia"] = deb.dia
				hash["anio"] = deb.anio
				hash["fecha"] = deb.fecha
				el_jason.push(hash)
			end
		end
		JSON.generate(el_jason) 
		render :text => JSON.generate(el_jason)
	end
end
