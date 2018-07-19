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
		@club = Iglesiasclube.find(current_user.accesId)
		@iglesia = Iglesia.find(@club.iglesia_id)		
		@distrito = Distrito.find(@iglesia.distrito_id)
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
		clubesarchivo = Clubesarchivo.where("id = #{params[:id]} AND iglesiasclubes_id = #{current_user.accesId}").first
		@clubesformulario = formulario.where("id = #{clubesarchivo.formularion_id}").first
		formulariodets = @camporeesarchivo.ruta_detalles.camelize.constantize 
		@formulariodets = formulariodets.where("#{@camporeesarchivo.campo_union} = #{@clubesformulario.id}").all
		puts @camporeesarchivo
		pdf = PdfformularioclubPdf.new(@camporeesarchivo, @formulariodets)
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