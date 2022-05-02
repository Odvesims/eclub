class CamposController < ApplicationController
	def index
		if signed_granted?(current_user.id, 'campos', 'I')
			@campos = Campo.where("#{current_user.default_level('campos')}").all
		end
	end
	
	def new
		if signed_granted?(current_user.id, 'campos', 'N')
			@campo = Campo.new
		end
	end
	
	def create
		if signed_granted?(current_user.id, 'campos', 'N')
			campo = Campo.new(params[:campo])
			if campo.save
				redirect_to action: 'edit', id: campo.id
				return
			end
		end
	end
	
	def edit
		if signed_granted?(current_user.id, 'campos', 'E')
			@campo = Campo.where("id = #{params[:id]}").first
			if params[:donde] == 'next'
				@campo = Campo.find(params[:id])
				@campo = @campo.next(@campo.id)
			else if params[:donde] == 'prev'
				@campo = Campo.find(params[:id])
				@campo = @campo.prev(@campo.id)
			end
			end	
		end
	end
	
	def update
		if signed_granted?(current_user.id, 'campos', 'E')
			campo = Campo.find(params[:id]) 
			if campo.update_attributes(params[:campo])
				redirect_to action: 'edit', id: campo.id
				return
			end
		end
	end
	
	def destroy
		if signed_granted?(current_user.id, 'campos', 'D')
			@campo = Campo.where("id = #{params[:id]}").first
			@campo.destroy
			redirect_to action: 'index'
			return
		end
	end	
	
end
