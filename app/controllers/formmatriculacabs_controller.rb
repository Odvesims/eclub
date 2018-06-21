class FormmatriculacabsController < ApplicationController
	before_filter :signed_in_user
	def index
		if signed_granted?(current_user.id, 'clubesarchivos', 'I')
			@clubesarchivos = Clubesarchivo.where("camporee_id = #{current_user.default_camporee} AND iglesiasclubes_id = 1").all
			@camporeesarchivos = Camporeesarchivo.where("camporee_id = #{current_user.default_camporee}").all
		end
	end
	
	def new
		if signed_granted?(current_user.id, 'clubesarchivos', 'N')
			@camporees = Camporee.where("id = #{current_user.default_camporee}").all
			@clubestipos = Clubestipo.all
			@clubesarchivo = Clubesarchivo.new
		end
	end
	
	def create
		if signed_granted?(current_user.id, 'clubesarchivos', 'N')
			club = Iglesiasclube.where("id = #{params[:iglesiasclube_id]}").first
			formulario = Formmatriculacab.new
				formulario.union_id = 1
				formulario.campo_id = club.campo_id 
				formulario.zona_id = club.zona_id 
				formulario.distrito_id = club.distrito_id 
				formulario.iglesia_id = club.iglesia_id 
				formulario.iglesiasclube_id = club.id
				formulario.nombre_pastor = params[:nombre_pastor]
				formulario.nombre_director = params[:nombre_pastor]
				formulario.fecha = params[:fecha]
			if formulario.save
				if params[:form_lines] && params[:form_lines]["tmpformlines"]
					detsForm = params[:form_lines]["tmpformlines"]
					puts detsForm
					if not detsForm == nil
						detsForm.each do |d|
							tipopersona_id = d["tipopersona_id"]
							nombre = d["nombre"]
							sexo = d["sexo"]
							edad = d["edad"]
							fecha_nacimiento = d["fecha_nacimiento"]
							nombre_tutor = d["nombre_tutor"]
							formulario_detalles = Formmatriculadet.new
								formulario_detalles.formmatriculacab_id = formulario.id
								formulario_detalles.tipopersona_id = tipopersona_id
								formulario_detalles.nombre = nombre
								formulario_detalles.sexo = sexo
								formulario_detalles.edad = edad
								formulario_detalles.fecha_nacimiento = fecha_nacimiento
								formulario_detalles.nombre_tutor = nombre_tutor
							if formulario_detalles.save
								clubesarchivo = Clubesarchivo.new
								clubesarchivo.camporee_id = current_user.default_camporee
								clubesarchivo.camporeesarchivos_id = params[:doc_id]
								clubesarchivo.iglesiasclubes_id = club.iglesia_id 
								clubesarchivo.user_id = current_user.name
								clubesarchivo.fecha_enviado = Time.now
								clubesarchivo.attachment = "N/A"
								clubesarchivo.save
							end
						end
					end
				end
			end
		end
	end
	
	def edit
		if signed_granted?(current_user.id, 'clubesarchivos', 'E')
			@camporees = Camporee.where("id = #{current_user.default_camporee}").all
			@clubestipos = Clubestipo.all
			@clubesarchivo = Clubesarchivo.find(params[:id]) 
			if params[:donde] == 'next'
				@clubesarchivo = Clubesarchivo.find(params[:id])
				@clubesarchivo = @clubesarchivo.next(@clubesarchivo.id)
			else if params[:donde] == 'prev'
				@clubesarchivo = Clubesarchivo.find(params[:id])
				@clubesarchivo = @clubesarchivo.prev(@clubesarchivo.id)
			end
			end	
		end
	end
	
	def update
		if signed_granted?(current_user.id, 'clubesarchivos', 'E')
			clubesarchivo = Clubesarchivo.find(params[:id]) 
			if clubesarchivo.update_attributes(params[:clubesarchivo])
				redirect_to action: 'edit', id: clubesarchivo.id
				return
			end
		end
	end
	
	def destroy
		if signed_granted?(current_user.id, 'clubesarchivos', 'D')
			@clubesarchivos = Clubesarchivo.find(params[:id]) 
			@clubesarchivos.destroy
			redirect_to action: 'index'
			return
		end
	end	
end
