class ConfiguracionesController < ApplicationController
	 def index
		@config = Configuracione.first
		@anio = @config.deboxional_year
		respond_to do |format|
			format.html # index.html.erb
		end
	 end
	 
	def show
		mes = params[:mes]
		config = Configuracione.first
		anio = config.deboxional_year
	end
	def new
		@config = Configuracione.first
		@anio = config.deboxional_year
		d = Date.parse(Date.today.to_s)
		@year = d.year.to_s
		respond_to do |format|
			format.html # new.html.erb
			format.json { render json: @config }
		end
	end
	  
	def create
		@config = Configuracione.first
		@anio = config.deboxional_year
		respond_to do |format|
			if @config.save
				format.html { redirect_to :action => :index }
			else
				format.html { redirect_to :action => :index }
			end
		end
	end

	def edit
		@config = Configuracione.first
	end

	def update
		@config = Configuracione.first
		respond_to do |format|
			if @config.update_attributes(params[:configuraciones])
				format.html { redirect_to :action => :edit }
				format.json { head :no_content }
			else
				format.html { redirect_to :action => :edit }
				format.json { render json: @config.errors, status: :unprocessable_entity }
			end
		end
	end
end
