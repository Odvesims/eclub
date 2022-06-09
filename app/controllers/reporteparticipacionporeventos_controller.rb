class ReporteparticipacionporeventosController < ApplicationController
	def index
		if signed_granted?(current_user.id, 'reporteparticipacionporeventos', 'I')
			@renglones = Camporeesrenglone.where("camporee_id = #{current_user.default_camporee}").all.order("id ASC")
			@zonas = Zona.where("zona_id != 0 AND #{current_user.default_level('zonas')}").all.order("zona_id ASC")
			@clubes_participantes = [] 
			@clubes_faltantes = []
			@club = 0
		end
	end
	
	def show
		if signed_granted?(current_user.id, 'reporteparticipacionporeventos', 'I')
			@clubes_participantes = []
			@clubes_faltantes = []
			whereZona = ""
			if params[:zona] != ""
				whereZona = "AND zona_id = #{params[:zona]}"
			end
			if params[:evento] != ""
				@clubes = Iglesiasclube.where("clubestipo_id = #{current_user.usersdefault.club_type} #{whereZona}").all.order("zona_id ASC")
				@clubes.each do |club|
					club_grade = CamporeeClubGrade.where("camporee_id = #{current_user.default_camporee} AND event_id = #{params[:evento]} AND club_id = #{club.id}").first
					#club_grade = Camporeespuntuacionescab.where("camporee_id = #{current_user.default_camporee} AND camporeesevento_id = #{params[:evento]} AND iglesiasclube_id = #{club.id}").first
					if not club_grade == nil
						@clubes_participantes.push(club)
					else
						@clubes_faltantes.push(club)
					end
				end
			end
			respond_to do |format|
				format.js
			end
		end
	end
end
