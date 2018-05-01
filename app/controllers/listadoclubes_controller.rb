class ListadoclubesController < ApplicationController
	before_filter :signed_in_user
	def index
		if signed_granted?(current_user.id, 'listadoclubes', 'I')
			@zonas = Zona.all
			@distritos = Distrito.all
			@iglesias = Iglesia.all
			@clubes = Iglesiasclube.all.sort_by(&:zonaId)
			@zona = 0
			@distrito = 0
			@iglesia = 0	
			@club = 0
		end
	end
	
	def show
		if signed_granted?(current_user.id, 'listadoclubes', 'I')	
			@zona = params[:zona].to_s
			@distrito = params[:distrito].to_s	
			sql = ""			
			if @zona != '' && @zona != ' ' 
				sql+= "zona_id = #{@zona}"
			end
			if @distrito != '' && @distrito != ' ' 
				if @zona != '' && @zona != ' ' 
					sql+= " AND"
				end
				slq+= " distrito_id = #{@distrito}"
			end
			@clubes = Iglesiasclube.where(sql).all.sort_by(&:zonaId)
			respond_to do |format|
				format.js
			end
		end
	end
	
	def edit	
		if signed_granted?(current_user.id, 'listadoclubes', 'E')	
			@zona = params[:zona].to_s
			@distrito = params[:distrito].to_s	
			sql = ""			
			if @zona != '' && @zona != '0' 
				sql+= "zona_id = #{@zona}"
			end
			if @distrito != '' && @distrito != '0' 
				if @zona != '' && @zona != '0' 
					sql+= " AND"
				end
				sql+= " distrito_id = #{@distrito}"
			end
			@clubes = Iglesiasclube.where(sql).all.sort_by(&:zonaId)
			pdf = PdflistadoclubesPdf.new(@clubes, current_user.default_camporee)
			name = 'listadoclubes.pdf'
			pdf.render_file File.join(Rails.root, "public/pdfs", name)
			send_data pdf.render , :filename => name , :type => "application/pdf", :disposition=> 'inline', :target => '_blank' 
		end
	end
end
