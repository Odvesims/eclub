class HojasevaluacionesController < ApplicationController
	before_filter :signed_in_user
	def index
		if signed_granted?(current_user.id, 'hojasevaluaciones', 'E')
			@eventos = Camporeesevento.where("camporee_id = #{current_user.default_camporee}").all
			@evento = @eventos[0].id
		end
	end
	
	def show
		if signed_granted?(current_user.id, 'hojasevaluaciones', 'I')
			@evento = params[:evento]
			respond_to do |format|
				format.js
			end
		end
	end
	
	def edit
		if signed_granted?(current_user.id, 'hojasevaluaciones', 'E')
			if not params[:evento]
				params[:evento] = 0
			end
			res = ActiveRecord::Base.connection.execute("SELECT get_hojasevaluacion(#{current_user.default_camporee}, #{params[:evento]})")
			@eventosTmp = Tmpeventocab.all
			@criteriosTmp = Tmpeventocriteriocab.all
			@detallesTmp = Tmpeventocriteriodet.all
			pdf = PdfhojasevaluacionesPdf.new(@eventosTmp, @criteriosTmp, @detallesTmp)
			name = 'hojasevaluaciones.pdf'
			pdf.render_file File.join(Rails.root, "public/pdfs", name)
			send_data pdf.render , :filename => name , :type => "application/pdf", :disposition=> 'inline', :target => '_blank'
		end
	end
end
