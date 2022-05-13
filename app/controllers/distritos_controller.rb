class DistritosController < ApplicationController
	def index
		if signed_granted?(current_user.id, 'distritos', 'I')
			@distritos = Distrito.all.sort_by(&:zonaId)
		end
	end
	
	def new
		if signed_granted?(current_user.id, 'distritos', 'N')
			@campos = Campo.where("#{current_user.default_level('campos')}").all
			@zonas = Zona.where("#{current_user.default_level('distritos')}").all.sort_by(&:zona_id)
			@distrito = Distrito.new
		end
	end
	
	def create
		if signed_granted?(current_user.id, 'distritos', 'N')
			distrito = Distrito.new(params[:distrito].to_enum.to_h)
			if distrito.save
				redirect_to action: 'edit', id: distrito.id
				return
			end
		end
	end
	
	def edit
		if signed_granted?(current_user.id, 'distritos', 'E')
			@campos = Campo.where("#{current_user.default_level('campos')}").all
			@zonas = Zona.where("#{current_user.default_level('distritos')}").all.sort_by(&:zona_id)
			@distrito = Distrito.find(params[:id]) 
			if params[:donde] == 'next'
				@distrito = Distrito.find(params[:id])
				@distrito = @distrito.next(@distrito.id)
			else if params[:donde] == 'prev'
				@distrito = Distrito.find(params[:id])
				@distrito = @distrito.prev(@distrito.id)
			end
			end
		end	
	end
	
	def update
		if signed_granted?(current_user.id, 'distritos', 'E')
			distrito = Distrito.find(params[:id]) 
			distrito.update(params[:distrito].to_enum.to_h)
			if distrito.save
				iglesias = Iglesia.where("distrito_id = #{distrito.id}").all
				iglesias.each do |iglesia|
					iglesia.zona_id = distrito.zona_id
					if iglesia.save
						clubes = Iglesiasclube.where("iglesia_id = #{iglesia.id}").all
						clubes.each do |club|
							club.zona_id = distrito.zona_id
							club.save
						end
					end
				end
				redirect_to action: 'edit', id: distrito.id
				return
			end
		end
	end
	
	def destroy
		if signed_granted?(current_user.id, 'distritos', 'D')
			@distrito = Distrito.find(params[:id]) 
			@distrito.destroy
			redirect_to action: 'index'
			return
		end
	end	
end
