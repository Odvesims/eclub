require 'rubygems'
require 'json'
require 'net/http'
require 'date'
 
class DeboxionalesController < ActionController::Base 
  respond_to :json 
	def index
		dia = Date.today.yday
		year = Date.today.year.to_s
		configuraciones = Configuracione.first	
		if dia > 0	
			if configuraciones.modalidad == "anual"
				deboxionales = Deboxionale.where("anio = '#{year}'").all
			elsif configuraciones.modalidad == "semanal"
				deboxionales = Deboxionale.where("dia >= #{dia}  AND dia <= #{dia} + 7 AND anio = '#{year}'").all
			elsif configuraciones.modalidad == "diario"
				deboxionales = Deboxionale.where("dia = #{dia} AND anio = '#{year}'").all
			end
		else	
			deboxionales = Deboxionale.all
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
  
	def show
		dia = Date.today.yday
		year = Date.today.year.to_s
		configuraciones = Configuracione.first	
		if dia > 0	
			if configuraciones.modalidad == "anual"
				deboxionales = Deboxionale.where("anio = '#{year}'").all
			elsif configuraciones.modalidad == "semanal"
				deboxionales = Deboxionale.where("dia >= #{dia}  AND dia <= #{dia} + 7 AND anio = '#{year}'").all
			elsif configuraciones.modalidad == "diario"
				deboxionales = Deboxionale.where("dia = #{dia} AND anio = '#{year}'").all
			end
		else	
			deboxionales = Deboxionale.all
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
	
	def create
		deboxional_ultimo = Deboxionale.last
		@deboxional = Deboxionale.new(params[:deboxionale])
		@deboxional.id = deboxional_ultimo.id + 1
		@deboxional.cuerpo.gsub(/\s+/, ' ')
		@deboxional.cuerpo.squeeze(" ")
		@deboxional.cuerpo.gsub('\\n', ' ')
		@deboxional.cuerpo.gsub('\\r', ' ')
		respond_to do |format|
			if @deboxional.save
				format.html { redirect_to edit_deboxionalesform }
			else
				format.html { redirect_to new_deboxionalesform }
			end
		end
	end
	
	def edit
		deboxional_ultimo = Deboxionale.last
		@deboxional = Deboxionale.where("id = #{deboxional_ultimo.id}").first
		@deboxional.id = deboxional_ultimo.id 
		if params[:donde] == 'next'
			@deboxional = Deboxionale.find(params[:id])
			@deboxional = @deboxional.next(@deboxional.id)
		else if params[:donde] == 'prev'
			@deboxional = Deboxionale.find(params[:id])
			@deboxional = @deboxional.prev(@deboxional.id)
		end
		end	
		respond_to do |format|
			if @deboxional.save
				format.html { redirect_to edit_deboxionalesform }
			else
				format.html { redirect_to edit_deboxionalesform }
			end
		end
	end
end
