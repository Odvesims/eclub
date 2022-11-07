class CamporeeseventosController < ApplicationController
	def index
		if signed_granted?(current_user.id, 'camporeeseventos', 'I')
			@camporeeseventos = Camporeesevento.where("camporee_id = #{current_user.default_camporee}").order("camporeesrenglone_id ASC").all
		end
	end
	
	def new
		if signed_granted?(current_user.id, 'camporeeseventos', 'N')
			@camporees = Camporee.where("id = #{current_user.default_camporee}").all
			@camporeesrenglones = Camporeesrenglone.where("camporee_id = #{current_user.default_camporee}").all
			@camporeesevento = Camporeesevento.new
		end
	end
	
	def create
		if signed_granted?(current_user.id, 'camporeeseventos', 'N')
			camporeesevento = Camporeesevento.new(params[:camporeesevento].to_enum.to_h)
			if camporeesevento.save!
				camporeesevento.errors.full_messages
				if params[:nombre] && params[:total_puntos]
					x = 0
					params[:nombre].each do |cab|
						i = 0
						if params[:nombre][x] != ""
							cabezera = Camporeeseventoscriterioscab.new
							cabezera.camporeesevento_id = params[:id]
							cabezera.nombre = params[:nombre][x]
							cabezera.total_puntos = params[:total_puntos][x]
							cabezera.save
						end
						if cabezera != nil
							if params[:nombre_detalle] && params[:puntos_detalle]
								params[:nombre_detalle].each do |det|	
									if params[:nombre_detalle][i] != ""												
										detalles = Camporeeseventoscriteriosdet.new
										detalles.camporeeseventoscriterioscab_id = cabezera.id
										detalles.nombre = params[:nombre_detalle][i]
										detalles.puntos = params[:puntos_detalle][i]
										detalles.camporeesevento_id = params[:id]
										detalles.save
									end
									i += 1
								end
							end
						end
						x += 1
					end
				end
				redirect_to action: 'edit', id: camporeesevento.id
				return	
			end
		end
	end
	
	def edit
		if signed_granted?(current_user.id, 'camporeeseventos', 'E')
			@camporees = Camporee.where("id = #{current_user.default_camporee}").all
			@camporeesrenglones = Camporeesrenglone.where("camporee_id = #{current_user.default_camporee}").all
			@camporeesevento = Camporeesevento.where("id = #{params[:id]}").first 
			@camporeeseventocriterios_cab = Camporeeseventoscriterioscab.where("camporeesevento_id = #{params[:id]}").all
			if params[:donde] == 'next'
				@camporeesevento = Camporeesevento.find(params[:id])
				@camporeesevento = @camporeesevento.next(@camporeesevento.id)
			else if params[:donde] == 'prev'
				@camporeesevento = Camporeesevento.find(params[:id])
				@camporeesevento = @camporeesevento.prev(@camporeesevento.id)
			end
			end	
		end
	end
	
	def update
		if signed_granted?(current_user.id, 'camporeeseventos', 'E')
			camporeesevento = Camporeesevento.find(params[:id]) 
			camporeesevento.update(params[:camporeesevento].to_enum.to_h)
			if camporeesevento.save
				if params[:nombre] && params[:total_puntos]
					x = 0
					params[:nombre].each do |cab|
						i = 0
						if params[:nombre][x] != ""
							cabezera = Camporeeseventoscriterioscab.where("camporeesevento_id = #{params[:id]} AND nombre = '#{params[:nombre][x]}' AND total_puntos = #{params[:total_puntos][x].to_i}").first
							if cabezera != nil
								cabezera.nombre = params[:nombre][x]
								cabezera.total_puntos = params[:total_puntos][x]
								cabezera.save
							else
								cabezera = Camporeeseventoscriterioscab.new
								cabezera.camporeesevento_id = params[:id]
								cabezera.nombre = params[:nombre][x]
								cabezera.total_puntos = params[:total_puntos][x]
								cabezera.save									
							end
						end
						if cabezera != nil
							if params[:nombre_detalle] && params[:puntos_detalle]
								params[:nombre_detalle].each do |det|	
									if params[:nombre_detalle][i] != ""
										detalles = Camporeeseventoscriteriosdet.where("camporeeseventoscriterioscab_id = #{cabezera.id} AND nombre = '#{params[:nombre_detalle][i]}'").first
										if detalles != nil
											detalles.nombre = params[:nombre_detalle][i]
											detalles.puntos = params[:puntos_detalle][i]
											detalles.camporeesevento_id = params[:id]
											detalles.save
										else							
											detalles = Camporeeseventoscriteriosdet.new
											detalles.camporeeseventoscriterioscab_id = cabezera.id
											detalles.nombre = params[:nombre_detalle][i]
											detalles.puntos = params[:puntos_detalle][i]
											detalles.camporeesevento_id = params[:id]
											detalles.save
										end
									end
									i += 1
								end
							end
						end
						x += 1
					end
				end
				redirect_to action: 'edit', id: camporeesevento.id
				return
			end
		end
	end
	
	def destroy
		if signed_granted?(current_user.id, 'camporeeseventos', 'D')
			@camporeesevento = Camporeesevento.find(params[:id]) 
			@camporeesevento.destroy
			redirect_to action: 'index'
			return
		end
	end	
end
