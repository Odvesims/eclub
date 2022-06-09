class ReportegeneralController < ApplicationController
	def index
		if signed_granted?(current_user.id, 'reportegeneral', 'E')
			@clubes = Iglesiasclube.where("#{current_user.default_level('iglesiasclubes')}").all
			@clubespuntos = nil 
			@club = 0
		end
	end
	
	def show
		if signed_granted?(current_user.id, 'reportegeneral', 'I')
			@control_js = 1		
			@club_grades = []
			@club_grades = CamporeeClubGrade.where("camporee_id = #{current_user.default_camporee}").select("(SELECT nombre FROM iglesiasclubes where id = club_id) AS club_name, (SELECT nombre FROM iglesias where id = (SELECT iglesia_id FROM iglesiasclubes WHERE clubestipo_id = #{current_user.club_type} AND id = camporee_club_grades.club_id LIMIT 1)) AS church_name, camporee_id, club_id, zone_id, sum(total_points) AS total_points").group("camporee_id, club_id, zone_id").order("#{params[:order_by]} #{params[:score_order]}, club_id")
			respond_to do |format|
				format.js
			end
		end
	end
	
	def edit
		if signed_granted?(current_user.id, 'reportegeneral', 'E')
			@clubespuntos = Camporeespuntuacionescab.where("camporee_id = #{current_user.default_camporee}").select("camporee_id, iglesiasclube_id, sum(total_puntos) as total_puntos").group("camporee_id, iglesiasclube_id").order("total_puntos DESC, iglesiasclube_id").sort_by(&:zonaId)
			pdf = PdfreportegeneralPdf.new(@clubespuntos)
			name = 'reportegeneral.pdf'
			pdf.render_file File.join(Rails.root, "public/pdfs", name)
			send_data pdf.render , :filename => name , :type => "application/pdf", :disposition=> 'inline', :target => '_blank'
		end
	end
end
