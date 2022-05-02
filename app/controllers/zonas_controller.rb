class ZonasController < ApplicationController
	def index
		if signed_granted?(current_user.id, 'zonas', 'I')
			@zonas = Zona.where("#{current_user.default_level('zonas')}").all
		end
	end
	
	def new
		if signed_granted?(current_user.id, 'zonas', 'N')
			@campos = Campo.all
			@zona = Zona.new
		end
	end
	
	def create
		if signed_granted?(current_user.id, 'zonas', 'N')
			zona = Zona.new(params[:zona].to_enum.to_h)
			if zona.save
				redirect_to action: 'edit', id: zona.id
				return
			end
		end
	end
	
	def edit
		if signed_granted?(current_user.id, 'zonas', 'E')
			@campos = Campo.all
			@zona = Zona.find(params[:id]) 
			if params[:donde] == 'next'
				@zona = Zona.find(params[:id])
				@zona = @zona.next(@zona.id)
			else if params[:donde] == 'prev'
				@zona = Zona.find(params[:id])
				@zona = @zona.prev(@zona.id)
			end
		end	
		end
	end
	
	def update
		if signed_granted?(current_user.id, 'zonas', 'E')
			zona = Zona.find(params[:id]) 
			zona.update(params[:zona].to_enum.to_h)
			if zona.save
					redirect_to action: 'edit', id: zona.id
				return
			end
		end
	end
	
	def destroy
		if signed_granted?(current_user.id, 'zonas', 'D')
			@zona = Zona.find(params[:id]) 
			@zona.destroy
			redirect_to action: 'index'
			return
		end
	end	
end
