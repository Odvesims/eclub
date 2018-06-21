class ClubesformulariosController < ApplicationController
	def new		
		@camporees = Camporee.where("id = #{current_user.default_camporee}").all
		@clubestipos = Clubestipo.all
		@camporeesarchivo = Camporeesarchivo.find(params[:doc_id])
		formulario = @camporeesarchivo.ruta_formulario.camelize.constantize
		@clubesformulario = formulario.new
		formulariodets = @camporeesarchivo.ruta_detalles.camelize.constantize 
		@formulariodets = formulariodets.new 
		@tiposPersonas = Tipopersona.where("categoria = 3").all
		@distrito = Distrito.find(19)
		@iglesia = Iglesia.where("distrito_id = #{@distrito.id}").first
		@club = Iglesiasclube.where("iglesia_id = #{@iglesia.id}").first
		@fecha = Date.today.strftime("%m/%d/%Y")
	end
	
	def create
		@clubesformulario = Clubesformulario.new(params[:clubesarchivo])
		if @clubesarchivo.save
			redirect_to action: 'edit', id: @clubesarchivo.id
			return
		end
	end
	
	def edit
		@camporeesarchivo = Camporeesarchivo.find(params[:tipo_doc])
		formulario = @camporeesarchivo.ruta_formulario.camelize.constantize
		@clubesformulario = formulario.where("id = #{params[:id]}").first
		formulariodets = @camporeesarchivo.ruta_detalles.camelize.constantize 
		@formulariodets = formulariodets.where("#{formulariodets.campo_union.camelize.constantize} = #{@clubesformulario.id}").all
		pdf = PdfformularioClubPdf.new(@camporeesarchivo, @formulariodets)
		name = 'formularioclub.pdf'
		pdf.render_file File.join(Rails.root, "public/pdfs", name)
		send_data pdf.render , :filename => name , :type => "application/pdf", :disposition=> 'inline', :target => '_blank' 
	end
	
	def update
		if signed_granted?(current_user.id, 'clubesarchivos', 'E')
			clubesarchivo = Clubesarchivo.find(params[:id]) 
			if clubesarchivo.update_attributes(params[:clubesarchivo])
			end
		end
	end
end