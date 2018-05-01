class IglesiasController < ApplicationController
	before_filter :signed_in_user
	def index
		if signed_granted?(current_user.id, 'iglesias', 'I')
			@iglesias = Iglesia.where("#{current_user.default_level('iglesias')}").all.sort_by{|i|[i.zonaId, i.distrito_id, i.id]}
		end
	end
	
	def new
		if signed_granted?(current_user.id, 'iglesias', 'N')
			@distritos = Distrito.where("#{current_user.default_level('iglesias')}").all
			@iglesia = Iglesia.new
		end
	end
	
	def create
		if signed_granted?(current_user.id, 'iglesias', 'N')
			iglesia = Iglesia.new(params[:iglesia])
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
			iglesia = Iglesia.find(params[:id]) 
			if iglesia.update_attributes(params[:iglesia])
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
