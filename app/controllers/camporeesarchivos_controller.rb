class CamporeesarchivosController < ApplicationController
	def index
		if signed_granted?(current_user.id, 'camporeesarchivos', 'I')
			@camporeesarchivos = Camporeesarchivo.where("camporee_id = #{current_user.default_camporee}").all
		end
	end
	
	def new
		if signed_granted?(current_user.id, 'camporeesarchivos', 'N')
			@camporees = Camporee.where("id = #{current_user.default_camporee}").all
			@clubestipos = Clubestipo.all
			@camporeesarchivo = Camporeesarchivo.new
		end
	end
	
	def create
		if signed_granted?(current_user.id, 'camporeesarchivos', 'N')
			camporeesarchivo = Camporeesarchivo.new(params[:camporeesarchivo])
			if camporeesarchivo.save
				redirect_to action: 'edit', id: camporeesarchivo.id
				return
			end
		end
	end
	
	def edit
		if signed_granted?(current_user.id, 'camporeesarchivos', 'E')
			@camporees = Camporee.where("id = #{current_user.default_camporee}").all
			@clubestipos = Clubestipo.all
			@camporeesarchivo = Camporeesarchivo.find(params[:id]) 
			if params[:donde] == 'next'
				@camporeesarchivo = Camporeesarchivo.find(params[:id])
				@camporeesarchivo = @camporeesarchivo.next(@camporeesarchivo.id)
			else if params[:donde] == 'prev'
				@camporeesarchivo = Camporeesarchivo.find(params[:id])
				@camporeesarchivo = @camporeesarchivo.prev(@camporeesarchivo.id)
			end
			end	
		end
	end
	
	def update
		if signed_granted?(current_user.id, 'camporeesarchivos', 'E')
			camporeesarchivo = Camporeesarchivo.find(params[:id]) 
			if camporeesarchivo.update_attributes(params[:camporeesarchivo])
				redirect_to action: 'edit', id: camporeesarchivo.id
				return
			end
		end
	end
	
	def destroy
		if signed_granted?(current_user.id, 'camporeesarchivos', 'D')
			@camporeesarchivos = Camporeesarchivo.find(params[:id]) 
			@camporeesarchivos.destroy
			redirect_to action: 'index'
			return
		end
	end	
end
