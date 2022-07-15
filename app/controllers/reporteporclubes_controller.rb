class ReporteporclubesController < ApplicationController
	def index
		if signed_granted?(current_user.id, 'reporteporclubes', 'I')
			@clubes = Iglesiasclube.where("#{current_user.default_level('iglesiasclubes')}").all
			if current_user.accessLevel == 'LC'
				@clubes = Iglesiasclube.where("id = #{current_user.accessId}").all
			else
			  @zonas = Zona.where("#{current_user.default_level('reporteporzona')}").all.order("zona_id ASC") 
			end
			@clubespuntos = nil 
			@club = 0
		end
	end
	
	def show
		if signed_granted?(current_user.id, 'reporteporclubes', 'I')
			@control_js = 1		
			if params[:club] == '' || params[:club] == 0
				@clubespuntos = nil
			else
				@clubespuntos = CamporeeClubGrade.where("camporee_id = #{current_user.default_camporee} AND club_id = #{params[:club]}").order("event_id ASC")
				#@clubespuntos = Camporeespuntuacionescab.where("camporee_id = #{current_user.default_camporee} AND iglesiasclube_id = #{params[:club]}").select("camporee_id, iglesiasclube_id, camporeerenglone_id, camporeesevento_id, sum(total_puntos) as total_puntos").group("camporee_id, iglesiasclube_id, camporeerenglone_id, camporeesevento_id").order("camporeerenglone_id, camporeesevento_id")
				@club = Iglesiasclube.find(params[:club])
				@iglesia = Iglesia.find(@club.iglesia_id)
				@zona = Zona.where("id = #{@club.zona_id}").first
				@campo = Campo.find(@club.campo_id)
			end
			respond_to do |format|
				format.js
			end
		end
	end
	
	def edit
		if signed_granted?(current_user.id, 'reporteporclubes', 'E')
			@clubespuntos = Camporeespuntuacionescab.where("camporee_id = #{current_user.default_camporee} AND iglesiasclube_id = #{params[:club]}").select("camporee_id, iglesiasclube_id, camporeerenglone_id, camporeesevento_id, sum(total_puntos) as total_puntos").group("camporee_id, iglesiasclube_id, camporeerenglone_id, camporeesevento_id").order("camporeerenglone_id, camporeesevento_id")
			@club = Iglesiasclube.find(params[:club])
			@iglesia = Iglesia.find(@club.iglesia_id)
			@zona = Zona.where("id = #{@club.zona_id}").first
			@campo = Campo.find(@club.campo_id)
			pdf = PdfreporteporclubPdf.new(@clubespuntos, @club, @iglesia, @zona)
			name = 'reporteporclub.pdf'
			pdf.render_file File.join(Rails.root, "public/pdfs", name)
			send_data pdf.render , :filename => name , :type => "application/pdf", :disposition=> 'inline', :target => '_blank' 
		end
	end
end
