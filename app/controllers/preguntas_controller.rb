class PreguntasController < ApplicationController
	 def index
		#@deboxionales = Deboxionalesformulario.all
		@preguntas = Pregunta.all
		@equipo_a = Equipo.where("id = 1").first
		@equipo_b = Equipo.where("id = 2").first
		respond_to do |format|
			format.html # index.html.erb
		end
	 end
	 
	def show
		@tipo = params[:tipo]
		if @tipo == 'temporizador'
			@temporizador_id = params[:idtempo]
		end
		if @tipo == 'despliega'
			@pregunta = nil
			i = 5
			z = 0
			while(z < i)
				number = rand(301..574)
				@pregunta = Pregunta.where("id = #{number} AND usada = false").first
				if @pregunta != nil
					@pregunta.usada = true
					@pregunta.save
					break
				end
			end
		end
		if @tipo == 'correcto'
			@equipo_activo = Equipo.where("activo = true").first
			@equipo_inactivo = Equipo.where("activo = false").first
			@equipo_activo.puntuacion = @equipo_activo.puntuacion.to_i + 1
			@equipo_activo.activo = false
			@equipo_inactivo.activo = true
			@equipo_activo.save
			@equipo_inactivo.save
		end
		if @tipo == 'incorrecto'
			@equipo_activo = Equipo.where("activo = true").first
			@equipo_inactivo = Equipo.where("activo = false").first
			@equipo_activo.activo = false
			@equipo_inactivo.activo = true
			@equipo_activo.save
			@equipo_inactivo.save
		end
	end
	def new
		@pregunta = Pregunta.new
	end
	  
	def create
		@pregunta = Pregunta.new(params[:pregunta])
		pregunta = Pregunta.last
		respond_to do |format|
			if @pregunta.save
				format.html { redirect_to :action => :new }
			else
				format.html { redirect_to :action => :new }
			end
		end
	end

	def edit
		@pregunta = Pregunta.where("id = #{params[:id]}").first
		if params[:donde] == 'next'
			@pregunta = Pregunta.find(params[:id])
			@pregunta = @pregunta.next(@pregunta.id)
		else if params[:donde] == 'prev'
			@pregunta = Pregunta.find(params[:id])
			@pregunta = @pregunta.prev(@pregunta.id)
		end
		end	
	end

	def update
		@pregunta = Pregunta.where("id = #{params[:id]}").first
		respond_to do |format|
			if @pregunta.update_attributes(params[:pregunta])
				format.html { redirect_to :action => :edit, :id => @pregunta.id }
				format.json { head :no_content }
			else
				format.html { redirect_to :action => :edit, :id => @pregunta.id }
				format.json { render json: @pregunta.errors, status: :unprocessable_entity }
			end
		end
	end
end
