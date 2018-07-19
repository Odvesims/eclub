class ClubesarchivosController < ApplicationController
	before_filter :signed_in_user
	def index
		if signed_granted?(current_user.id, 'clubesarchivos', 'I')
			@clubesarchivos = Clubesarchivo.where("camporee_id = #{current_user.default_camporee} AND iglesiasclubes_id = #{current_user.accesId}").all
			@camporeesarchivos = Camporeesarchivo.where("camporee_id = #{current_user.default_camporee}").all
		end
	end
	
	def new
		if signed_granted?(current_user.id, 'clubesarchivos', 'N')
			@camporees = Camporee.where("id = #{current_user.default_camporee}").all
			@clubestipos = Clubestipo.all
			@clubesarchivo = Clubesarchivo.new
		end
	end
	
	def create
		if signed_granted?(current_user.id, 'clubesarchivos', 'N')
			@clubesarchivo = Clubesarchivo.new(params[:clubesarchivo])
			if @clubesarchivo.save
				redirect_to action: 'edit', id: @clubesarchivo.id
				return
			end
		end
	end
	
	def edit
		if signed_granted?(current_user.id, 'clubesarchivos', 'E')
			@camporees = Camporee.where("id = #{current_user.default_camporee}").all
			@clubestipos = Clubestipo.all
			@clubesarchivo = Clubesarchivo.find(params[:id]) 
			if @clubesarchivo.iglesiasclubes_id = current_user.accesId
				if params[:donde] == 'next'
					@clubesarchivo = Clubesarchivo.find(params[:id])
					@clubesarchivo = @clubesarchivo.next(@clubesarchivo.id)
				else if params[:donde] == 'prev'
					@clubesarchivo = Clubesarchivo.find(params[:id])
					@clubesarchivo = @clubesarchivo.prev(@clubesarchivo.id)
				end
				end	
			end
		end
	end
	
	def update
		if signed_granted?(current_user.id, 'clubesarchivos', 'E')
			clubesarchivo = Clubesarchivo.find(params[:id]) 
			if clubesarchivo.update_attributes(params[:clubesarchivo])
				redirect_to action: 'edit', id: clubesarchivo.id
				return
			end
		end
	end
	
	def destroy
		if signed_granted?(current_user.id, 'clubesarchivos', 'D')
			@clubesarchivos = Clubesarchivo.find(params[:id]) 
			@clubesarchivos.destroy
			redirect_to action: 'index'
			return
		end
	end	
end
