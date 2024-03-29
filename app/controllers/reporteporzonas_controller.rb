class ReporteporzonasController < ApplicationController
	def index
		if signed_granted?(current_user.id, 'reporteporzonas', 'I')
			@zonas = Zona.where("#{current_user.default_level('reporteporzonas')}").all.order("zona_id ASC")
			@clubespuntos = nil 
			@club = 0
		end
	end
	
	def show
		if signed_granted?(current_user.id, 'reporteporzonas', 'I')
			@control_js = 1		
			if params[:zona] == '' || params[:zona] == 0
				@clubespuntos = nil
			else
				@clubespuntos = CamporeeClubGrade.where("camporee_id = #{current_user.default_camporee} AND zone_id = #{params[:zona]} AND club_id IN (SELECT id FROM iglesiasclubes WHERE clubestipo_id = 2)").all.order("zone_id ASC, event_id ASC")			
				#@clubespuntos = Camporeespuntuacionescab.where("camporee_id = #{current_user.default_camporee} AND zona_id = #{params[:zona]}").select("camporee_id, iglesiasclube_id, camporeerenglone_id, camporeesevento_id, sum(total_puntos) as total_puntos").group("camporee_id, iglesiasclube_id, camporeerenglone_id, camporeesevento_id").order("camporeerenglone_id, camporeesevento_id")
				@zona = Zona.find(params[:zona])
				@campo = Campo.find(@zona.campo_id)
			end
			respond_to do |format|
				format.js
			end
		end
	end
	
	def edit
		if signed_granted?(current_user.id, 'reporteporzonas', 'E')
			@clubespuntos = Camporeespuntuacionescab.where("camporee_id = #{current_user.default_camporee} AND zona_id = #{params[:zona]}").select("camporee_id, iglesiasclube_id, camporeerenglone_id, camporeesevento_id, sum(total_puntos) as total_puntos").group("camporee_id, iglesiasclube_id, camporeerenglone_id, camporeesevento_id").order("camporeerenglone_id, camporeesevento_id")
			@zona = Zona.find(params[:zona])
			@campo = Campo.find(@zona.campo_id)
			pdf = PdfreporteporzonaPdf.new(@clubespuntos, @zona)
			name = 'reporteporzona.pdf'
			pdf.render_file File.join(Rails.root, "public/pdfs", name)
			send_data pdf.render , :filename => name , :type => "application/pdf", :disposition=> 'inline', :target => '_blank' 
		end
	end
end
