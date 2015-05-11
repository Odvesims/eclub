class DeboxionalesformulariosController < ApplicationController
	 def index
		#@deboxionales = Deboxionalesformulario.all
		config = Configuracione.first
		@anio = config.deboxional_year
		respond_to do |format|
			format.html # index.html.erb
		end
	 end
	 
	def show
		mes = params[:mes]
		config = Configuracione.first
		anio = config.deboxional_year
		@deboxionales = Deboxionalesformulario.where("fecha_dia LIKE '%#{mes}' AND anio = '#{anio}'").all
	end
	def new
		config = Configuracione.first
		@anio = config.deboxional_year
		@deboxional = Deboxionalesformulario.new
		d = Date.parse(Date.today.to_s)
		@year = d.year.to_s
		respond_to do |format|
			format.html # new.html.erb
			format.json { render json: @deboxional }
		end
	end
	  
	def create
		config = Configuracione.first
		@anio = config.deboxional_year
		@deboxional = Deboxionalesformulario.new(params[:deboxionalesformulario])
		deboxional = Deboxionalesformulario.last
		my_string = @deboxional.fecha_dia
		mes = ""
		if my_string.include? "Enero"
		   mes = "01"
		elsif my_string.include? "Febrero"
		   mes = "02"
		elsif my_string.include? "Marzo"
		   mes = "03"
		elsif my_string.include? "Abril"
		   mes = "04"
		elsif my_string.include? "Mayo"
		   mes = "05"
		elsif my_string.include? "Junio"
		   mes = "06"
		elsif my_string.include? "Julio"
		   mes = "07"
		elsif my_string.include? "Agosto"
		   mes = "08"
		elsif my_string.include? "Septiembre"
		   mes = "09"
		elsif my_string.include? "Octubre"
		   mes = "10"
		elsif my_string.include? "Noviembre"
		   mes = "11"
		elsif my_string.include? "Diciembre"
		   mes = "12"
		end
		dia = my_string.gsub(/[^0-9,.]/, "");
		dia = dia.gsub!(',','')
		year = @deboxional.anio
		fecha_deboxion = Date.parse(year + "-" + mes + "-" + dia)
		@deboxional.fecha = Date.parse(year + "-" + mes + "-" + dia)
		@deboxional.dia = fecha_deboxion.yday.to_s
		@deboxional.id = deboxional.id + 2
		respond_to do |format|
			if @deboxional.save
				format.html { redirect_to :action => :index }
			else
				format.html { redirect_to :action => :index }
			end
		end
	end

	def edit
		config = Configuracione.first
		@anio = config.deboxional_year
		@deboxional = Deboxionalesformulario.where("id = #{params[:id]}").first
		if params[:donde] == 'next'
			@deboxional = Deboxionalesformulario.find(params[:id])
			@deboxional = @deboxional.next(@deboxional.id)
		else if params[:donde] == 'prev'
			@deboxional = Deboxionalesformulario.find(params[:id])
			@deboxional = @deboxional.prev(@deboxional.id)
		end
		end	
	end

	def update
		config = Configuracione.first
		@anio = config.deboxional_year
		@deboxional = Deboxionalesformulario.where("id = #{params[:id]}").first
		@deboxional.cuerpo.gsub(/\s+/, ' ')
		respond_to do |format|
			if @deboxional.update_attributes(params[:deboxionalesformulario])
				format.html { redirect_to :action => :edit }
				format.json { head :no_content }
			else
				format.html { redirect_to :action => :edit }
				format.json { render json: @deboxional.errors, status: :unprocessable_entity }
			end
		end
	end
end
