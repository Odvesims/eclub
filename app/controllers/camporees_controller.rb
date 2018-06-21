class CamporeesController < ApplicationController
	before_filter :signed_in_user
	def index
		if signed_granted?(current_user.id, 'camporees', 'I')
			@camporees = Camporee.where("id = #{current_user.default_camporee}").all
		end
	end
	
	def new
		if signed_granted?(current_user.id, 'camporees', 'N')
			@campos = Campo.all
			@clubestipos = Clubestipo.all
			@camporee = Camporee.new
		end
	end
	
	def create
		if signed_granted?(current_user.id, 'camporees', 'N')
			camporee = Camporee.new(params[:camporee])
			camporee.fecha = params[:fecha]
			if camporee.save
				redirect_to action: 'edit', id: camporee.id
				return
			end
		end
	end
	
	def edit
		if signed_granted?(current_user.id, 'camporees', 'E')
			@campos = Campo.all
			@clubestipos = Clubestipo.all
			@camporee = Camporee.find(params[:id]) 
			if params[:donde] == 'next'
				@camporee = Camporee.find(params[:id])
				@camporee = @camporee.next(@camporee.id)
			else if params[:donde] == 'prev'
				@camporee = Camporee.find(params[:id])
				@camporee = @camporee.prev(@camporee.id)
			end
			end	
		end
	end
	
	def update
		if signed_granted?(current_user.id, 'camporees', 'E')
			camporee = Camporee.find(params[:id]) 
			if camporee.update_attributes(params[:camporee])
				camporee.fecha = params[:fecha]
				camporee.save
				redirect_to action: 'edit', id: camporee.id
				return
			end
		end
	end
	
	def destroy
		if signed_granted?(current_user.id, 'camporees', 'D')
			@camporee = Camporee.find(params[:id]) 
			@camporee.destroy
			redirect_to action: 'index'
			return
		end
	end	
end
