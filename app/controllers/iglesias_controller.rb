class IglesiasController < ApplicationController
	def index
		if signed_granted?(current_user.id, 'iglesias', 'I')
			@iglesias = Iglesia.where("#{current_user.default_level('iglesias')}").all.sort_by{|i|[i.zona_id, i.distrito_id, i.nombre]}
		end
	end
	
	def new
		if signed_granted?(current_user.id, 'iglesias', 'N')
			@zonas = Zona.where("zona_id > 0 AND campo_id = #{current_user.default_conference}").all.order("zona_id ASC")
			@distritos = Distrito.where("#{current_user.default_level('iglesias')}").all
			@iglesia = Iglesia.new
		end
	end
	
	def create
		if signed_granted?(current_user.id, 'iglesias', 'N')
			@zonas = Zona.where("zona_id > 0 AND campo_id = #{current_user.default_conference}").all.order("zona_id ASC")
			iglesia = Iglesia.new(params[:iglesia].to_enum.to_h)
			distrito = Distrito.find(params[:iglesia][:distrito_id])
			iglesia.campo_id = distrito.campo_id
			iglesia.zona_id = distrito.zona_id
			if iglesia.save
				redirect_to action: 'edit', id: iglesia.id
				return
			end
		end
	end
	
	def edit
		if signed_granted?(current_user.id, 'iglesias', 'E')
			@zonas = Zona.where("zona_id > 0 AND campo_id = #{current_user.default_conference}").all.order("zona_id ASC")
			@iglesia = Iglesia.find(params[:id]) 
			@distritos = Distrito.where("#{current_user.default_level('iglesias')}").all
			if params[:donde] == 'next'
				@iglesia = Iglesia.find(params[:id])
				@iglesia = @iglesia.next(@iglesia.id)
			else if params[:donde] == 'prev'
				@iglesia = Iglesia.find(params[:id])
				@iglesia = @iglesia.prev(@iglesia.id)
			end
			end
		end	
	end
	
	def update
		if signed_granted?(current_user.id, 'iglesias', 'E')
			@zonas = Zona.where("zona_id > 0 AND campo_id = #{current_user.default_conference}").all.order("zona_id ASC")
			iglesia = Iglesia.find(params[:id]) 
			iglesia.update(params[:iglesia].to_enum.to_h)
			if iglesia.save
				UpdateZoneIdService.new( {level: 'CH', id: iglesia.id, zone_id: iglesia.zona_id} ).execute
				redirect_to action: 'edit', id: iglesia.id
				return
			end
		end
	end
	
	def destroy
		if signed_granted?(current_user.id, 'iglesias', 'D')
			@iglesia = Iglesia.find(params[:id]) 
			@iglesia.destroy
			redirect_to action: 'index'
			return
		end
	end	
end
