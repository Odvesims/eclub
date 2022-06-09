class IglesiasclubesController < ApplicationController
	def index
		if signed_granted?(current_user.id, 'iglesiasclubes', 'I')
			@iglesiasclubes = Iglesiasclube.where("#{current_user.default_level('iglesiasclubes')} AND clubestipo_id = #{current_user.club_type}").all.sort_by{|c|[c.zonaId, c.nombre]}
		end
	end
	
	def new
		if signed_granted?(current_user.id, 'iglesiasclubes', 'N')
			@clubType = current_user.club_type
			@iglesias = Iglesia.where("NOT EXISTS (SELECT 1 FROM iglesiasclubes WHERE iglesiasclubes.iglesia_id = iglesias.id AND iglesiasclubes.clubestipo_id = #{current_user.club_type})").all
			@clubestipos = Clubestipo.all
			@iglesiasclube = Iglesiasclube.new
			@zonas = Zona.where("zona_id > 0 AND campo_id = #{current_user.default_conference}").all.order("zona_id ASC")
		end
	end
	
	def show
		@iglesias = ActiveRecord::Base.connection.execute("SELECT id, nombre FROM iglesias i WHERE NOT EXISTS (SELECT 1 FROM iglesiasclubes c WHERE  i.id = c.iglesia_id AND c.clubestipo_id = #{current_user.club_type})")
	end
	
	def create
		if signed_granted?(current_user.id, 'iglesiasclubes', 'N')
			iglesiasclube = Iglesiasclube.new(params[:iglesiasclube].to_enum.to_h)
			clubes = Iglesiasclube.where("clubestipo_id = #{current_user.club_type}").all
			club_exists = clubes.where("iglesia_id = #{params[:iglesiasclube][:iglesia_id]}").first
			if club_exists != nil
				redirect_to action: 'new', message: 'La iglesia seleccionada ya tiene un club de este tipo registrado'
				return
			end
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
			iglesiasclube.update(params[:iglesiasclube].to_enum.to_h)
			if iglesiasclube.save
				UpdateZoneIdService.new('CL', iglesiasclube.id, iglesiasclube.zona_id).execute
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
