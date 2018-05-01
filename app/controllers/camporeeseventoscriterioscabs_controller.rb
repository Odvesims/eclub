class CamporeeseventoscriterioscabsController < ApplicationController	
	def camporeeseventoscriterioscabs_params
		params.require(:camporeeseventoscriterioscab).permit(:nombre, :total_puntos, camporeeseventoscriteriosdets_attributes: [:id, :camporeeseventoscriterioscab_id, :nombre, :total_puntos, :_destroy])
	end
end
