class CamporeespuntuacionescabsController < ApplicationController
	def index
		if signed_granted?(current_user.id, 'camporeespuntuacionescabs', 'I')
			@iglesias = Iglesia.where("#{current_user.default_level('iglesias')}").all
			@eventos = Camporeesevento.where("camporee_id = #{current_user.default_camporee}").all
			@renglones = Camporeesrenglone.where("camporee_id = #{current_user.default_camporee}").all
			@clubes = Iglesiasclube.where("#{current_user.default_level('iglesiasclubes')}").all
			@camporeespuntuacionescabs = Camporeespuntuacionescab.where("id = 0").all 
			#@camporeespuntuacionescabs = Camporeespuntuacionescab.where("camporee_id = #{current_user.default_camporee}").select("iglesiasclube_id, camporeerenglone_id, camporeesevento_id, sum(total_puntos) as total_puntos").group("iglesiasclube_id, camporeerenglone_id, camporeesevento_id")
			@club = 0
			@renglon = 0
			@evento = 0
			@iglesia = 0
		end
	end
	
	def show
		if signed_granted?(current_user.id, 'camporeespuntuacionescabs', 'I')
			if params[:id] == 'nuevo'
				@zonas = Zona.where("zona_id > 0 AND campo_id = #{current_user.default_conference}").all.order("zona_id ASC")
				@eventos = Camporeesevento.where("camporee_id = #{current_user.default_camporee}").all
				@clubes = Iglesiasclube.where("#{current_user.default_level('iglesiasclubes')}").all
				@evento = 0
			else
				if params[:option] == 'renderCriterios'
					@eventos = Camporeesevento.where("camporee_id = #{current_user.default_camporee}").all
					@clubes = Iglesiasclube.all	
					@control_js = 2
					@evento = params[:evento].to_s
					@club = params[:club].to_s
					@evento_registrado = false
					@edita_nuevo = "nuevo"
					event = Camporeesevento.find(@evento)
					@zone_event = event.evento_zonal
					if @evento != '' && @evento != ' ' && @club != '' && @club != ' ' 
						@criterios_cab = Camporeeseventoscriterioscab.where("camporeesevento_id = #{@evento}").all
						#@camporeespuntuacionescab = Camporeespuntuacionescab.where("camporee_id = #{current_user.default_camporee} AND camporeesevento_id = #{params[:evento]} AND iglesiasclube_id = #{params[:club]}").first
						@camporeespuntuacionescab = CamporeeClubGrade.where("camporee_id = #{current_user.default_camporee} AND event_id = #{params[:evento]} AND club_id = #{params[:club]}").first
						if @camporeespuntuacionescab != nil
							@evento_registrado = true
							@edita_nuevo = "edita"						
						end
					else
						@criterios_cab = nil
					end					
					respond_to do |format|
						format.js
					end
				else
					@control_js = 1
					@evento = params[:evento].to_s
					@renglon = params[:renglon].to_s
					@club = params[:club].to_s
					@iglesia = params[:iglesia].to_s
					@iglesias = Iglesia.all
					@eventos = Camporeesevento.where("camporee_id = #{current_user.default_camporee}").all
					@renglones = Camporeesrenglone.where("camporee_id = #{current_user.default_camporee}").all
					@clubes = Iglesiasclube.all
					sql = "camporee_id = #{current_user.default_camporee}"
					if @club != '' && @club != ' ' 
						sql += " AND iglesiasclube_id = #{@club} "
						iglesia_club = Iglesiasclube.find(@club)
						@iglesias = Iglesia.where("id = #{iglesia_club.iglesia_id}").all
					else
						@club = 0
					end
					
					if @renglon != '' && @renglon != ' ' 
						sql += " AND camporeerenglone_id = #{@renglon} "
						@eventos = Camporeesevento.where("camporee_id = #{current_user.default_camporee} AND camporeesrenglone_id = #{@renglon}").all
					else
						@renglon = 0
					end
					
					if @evento != '' && @evento != ' ' 
						sql += " AND camporeesevento_id = #{@evento} "
						evento = Camporeesevento.find(@evento)
						@renglones = Camporeesrenglone.where("id = #{evento.camporeesrenglone_id}").all
					else
						@evento = 0
					end
					
					if @iglesia != '' && @iglesia != ' ' 
						sql += " AND iglesia_id = #{@iglesia} "
						@club = 0
						@clubes = Iglesiasclube.where("iglesia_id = #{@iglesia}").all
					else
						@iglesia = 0
					end
					
					@camporeespuntuacionescabs = Camporeespuntuacionescab.where("camporee_id = #{current_user.default_camporee} AND " + sql).select("iglesiasclube_id, camporeerenglone_id, camporeesevento_id, sum(total_puntos) as total_puntos").group("iglesiasclube_id, camporeerenglone_id, camporeesevento_id")	
					respond_to do |format|
						format.js
					end
				end		
			end
		end
	end
	
	def new
		if signed_granted?(current_user.id, 'camporeespuntuacionescabs', 'N')
			@campos = Campo.all
			@clubestipos = Clubestipo.all
		end
	end
	
	def create
		if signed_granted?(current_user.id, 'camporeespuntuacionescabs', 'N')
			evento = params[:elEvento]	
			club = params[:elClub]	
			@clubes = Iglesiasclube.where("id = #{club}").all
			if params[:modo_registro].to_i == 2
				@clubes = Iglesiasclube.all
			end
			event = Camporeesevento.find(evento)
			if event.evento_zonal
				club = Iglesiasclube.find(club)
				@clubes = Iglesiasclube.where("zona_id = #{club.zona_id} AND clubestipo_id = #{current_user.club_type}").all
			end
			@clubes.each do |c|
				club = c.id
				clube = Iglesiasclube.find(club)
				iglesia = Iglesia.find(clube.iglesia_id)
				event = Camporeesevento.find(evento)
				clearOldGrades(current_user.default_camporee, evento, club)
				@club_grades = nil
				i = 0
				e = 0
				details_arr = []
				total_points = 0
				while i < params[:valueI].to_i
					cab_id = params[:criterio_cabeza][:tmpcabeza][i.to_s][:camporeeseventoscriterioscab_id].to_s
					e = 0
					while e < params[:valueE].to_i
						if params[:criterio_detalles_puntos][:tmpdetallespuntos][e.to_s][:puntos].to_s != '' && params[:criterio_detalles_puntos][:tmpdetallespuntos][e.to_s][:puntos].to_s != ' '
							puntos = params[:criterio_detalles_puntos][:tmpdetallespuntos][e.to_s][:puntos].to_s
							criterio_cabeza_id = params[:criterio_detalles_puntos][:tmpdetallespuntos][e.to_s][:criteriocabeza_id].to_s
							criterio_head = Camporeeseventoscriterioscab.find(criterio_cabeza_id)
							camporeeseventoscriteriosdet_id = params[:criterio_detalles_puntos][:tmpdetallespuntos][e.to_s][:camporeeseventoscriteriosdet_id].to_i
							criterio_det = Camporeeseventoscriteriosdet.find(camporeeseventoscriteriosdet_id)
							detail = { points: puntos, event_head: { id: criterio_cabeza_id, name: criterio_head.nombre }, event_detail: { id: camporeeseventoscriteriosdet_id, name: criterio_det.nombre } }
							total_points += puntos.to_f
							if criterio_cabeza_id.to_i == cab_id.to_i
							end
							details_arr.push(detail)
						end
						e += 1
					end		
					@club_grades = CamporeeClubGrade.create({ camporee_id: current_user.default_camporee, club_id: club, event_id: evento, total_points: total_points, zone_id: clube.zona_id, created_at: Time.now, updated_at: Time.now, created_by: current_user.login, updated_by: current_user.login, signed_by: '', notes: '', details: details_arr.to_json})	
					i += 1
				end
			end
			respond_to do |format|
				@puntuaciones = Camporeespuntuacionescab.where("camporee_id = #{current_user.default_camporee} AND iglesiasclube_id = #{@clubes[0].id} AND camporeesevento_id = #{evento}").all
				format.html { render "edit" }
				format.js
			end
		end
	end
	
	def edit
		if signed_granted?(current_user.id, 'camporeespuntuacionescabs', 'E')
			@puntuaciones = Camporeespuntuacionescab.where("camporee_id = #{current_user.default_camporee} AND iglesiasclube_id = #{params[:club_id]} AND camporeesevento_id = #{params[:evento_id]}").all
		end
	end
	
	def update
		if signed_granted?(current_user.id, 'camporeespuntuacionescabs', 'E')
			camporee = Camporee.find(params[:id]) 
			if camporee.update_attributes(camporees_params)
				redirect_to action: 'edit', id: camporee.id
				return
			end
		end
	end
	
	def destroy
		if signed_granted?(current_user.id, 'camporeespuntuacionescabs', 'D')
			@camporee = Camporee.find(params[:id]) 
			@camporee.destroy
			redirect_to action: 'index'
			return
		end
	end	

	private

		def clearOldGrades(camporee_id, event_id, club_id)
			grades = CamporeeClubGrade.where("camporee_id = #{camporee_id} AND event_id = #{event_id} AND club_id = #{club_id}").all
			grades.each do |grade|
				grade.destroy!
			end
		end
end
