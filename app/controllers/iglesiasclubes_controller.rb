class IglesiasclubesController < ApplicationController
	before_filter :signed_in_user
	def index
		if signed_granted?(current_user.id, 'iglesiasclubes', 'I')
		@iglesiasclubes = Iglesiasclube.where("#{current_user.default_level('iglesiasclubes')}").all.sort_by{|c|[c.zonaId, c.distrito_id, c.iglesia_id]}
		end
	end
	
	def new
		if signed_granted?(current_user.id, 'iglesiasclubes', 'N')
			@iglesias = Iglesia.where("NOT EXISTS (SELECT 1 FROM iglesiasclubes WHERE iglesiasclubes.iglesia_id = iglesias.id AND iglesiasclubes.clubestipo_id = 2)").all
			@clubestipos = Clubestipo.all
			@iglesiasclube = Iglesiasclube.new
		end
	end
	
	def show
		@iglesias = ActiveRecord::Base.connection.execute("SELECT id, nombre FROM iglesias i WHERE NOT EXISTS (SELECT 1 FROM iglesiasclubes c WHERE  i.id = c.iglesia_id AND c.clubestipo_id = 1)")
	end
	
	def create
		if signed_granted?(current_user.id, 'iglesiasclubes', 'N')
			iglesiasclube = Iglesiasclube.new(params[:iglesiasclube])
			iglesia = Iglesia.find(params[:iglesiasclube][:iglesia_id])
			iglesiasclube.campo_id = iglesia.campo_id
			iglesiasclube.zona_id = iglesia.zona_id
			iglesiasclube.distrito_id = iglesia.distrito_id
			if iglesiasclube.save
				redirect_to action: 'new'
				return
			end
		end
	end
	
	def edit
		if signed_granted?(current_user.id, 'iglesiasclubes', 'E')
			@iglesiasclube = Iglesiasclube.find(params[:id]) 
			@iglesias = Iglesia.where("#{current_user.default_level('iglesiasclubes')}").all.sort_by(&:zonaId)
			@clubestipos = Clubestipo.all
			if params[:donde] == 'next'
				@iglesiasclube = Iglesiasclube.find(params[:id])
				@iglesiasclube = @iglesiasclube.next(@iglesiasclube.id)
			else if params[:donde] == 'prev'
				@iglesiasclube = Iglesiasclube.find(params[:id])
				@iglesiasclube = @iglesiasclube.prev(@iglesiasclube.id)
			end
			end	
		end
	end
	
	def update
		if signed_granted?(current_user.id, 'iglesiasclubes', 'E')
			iglesiasclube = Iglesiasclube.find(params[:id]) 
			if iglesiasclube.update_attributes(params[:iglesiasclube])
				redirect_to action: 'edit', id: iglesiasclube.id
				return
			end
		end
	end
	
	def destroy
		if signed_granted?(current_user.id, 'iglesiasclubes', 'D')
			@iglesiasclube = Iglesiasclube.find(params[:id]) 
			@iglesiasclube.destroy
			redirect_to action: 'index'
			return
		end
	end	
end
