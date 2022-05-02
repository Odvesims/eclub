class CamporeesrenglonesController < ApplicationController
	def index
		if signed_granted?(current_user.id, 'camporeesrenglones', 'I')
			@camporeesrenglones = Camporeesrenglone.where("camporee_id = #{current_user.default_camporee}").all
		end
	end
	
	def new
		if signed_granted?(current_user.id, 'camporeesrenglones', 'N')
			@camporees = Camporee.where("id = #{current_user.default_camporee}").all
			@clubestipos = Clubestipo.all
			@camporeesrenglon = Camporeesrenglone.new
		end
	end
	
	def create
		if signed_granted?(current_user.id, 'camporeesrenglones', 'N')
			camporeesrenglon = Camporeesrenglone.new(params[:camporeesrenglone].to_enum.to_h)
			if camporeesrenglon.save
				redirect_to action: 'edit', id: camporeesrenglon.id
				return
			end
		end
	end
	
	def edit
		if signed_granted?(current_user.id, 'camporeesrenglones', 'E')
			@camporees = Camporee.where("id = #{current_user.default_camporee}").all
			@clubestipos = Clubestipo.all
			@camporeesrenglon = Camporeesrenglone.find(params[:id]) 
			if params[:donde] == 'next'
				@camporeesrenglon = Camporeesrenglone.find(params[:id])
				@camporeesrenglon = @camporeesrenglon.next(@camporeesrenglon.id)
			else if params[:donde] == 'prev'
				@camporeesrenglon = Camporeesrenglone.find(params[:id])
				@camporeesrenglon = @camporeesrenglon.prev(@camporeesrenglon.id)
			end
			end	
		end
	end
	
	def update
		if signed_granted?(current_user.id, 'camporeesrenglones', 'E')
			camporeesrenglon = Camporeesrenglone.find(params[:id]) 
			camporeesrenglon.update(params[:camporeesrenglone].to_enum.to_h)
			if camporeesrenglon.save
				redirect_to action: 'edit', id: camporeesrenglon.id
				return
			end
		end
	end
	
	def destroy
		if signed_granted?(current_user.id, 'camporeesrenglones', 'D')
			@camporeesrenglones = Camporeesrenglone.find(params[:id]) 
			@camporeesrenglones.destroy
			redirect_to action: 'index'
			return
		end
	end	
end
