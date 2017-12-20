class RolesController < ApplicationController
before_filter :signed_in_user 
  def index
  	xuser = current_user 
	if signed_granted?(xuser.id, 'roles', 'I')
		@roles = Rol.where("menu_cod = '#{$menugral}' OR trim(menu_cod) = '' or menu_cod is null ").paginate(page: params[:page])
		respond_to do |format|
		  format.html # index.html.erb
		  format.json { render json: @roles }
		end
	end
  end

  def show
  	xuser = current_user
	if signed_granted?(xuser.id, 'roles', 'I')
		@rol = Rol.find(params[:id])
		respond_to do |format|
		  format.html # show.html.erb
		  format.json { render json: @rol }
		end
	end
  end

  def new
    xuser = current_user
	if signed_granted?(xuser.id, 'roles', 'N')
		@rol = Rol.new
		respond_to do |format|
		  format.html # new.html.erb
		  format.json { render json: @rol }
		end
	end
  end
  
  def edit
    xuser = current_user
	if signed_granted?(xuser.id, 'roles', 'N')
		@rol = Rol.find(params[:id])
		if params[:donde] == 'next'
			@rol = rol.find(params[:id])
			@rol = @rol.next(@rol.id)
		else if params[:donde] == 'prev'
			@rol = Rol.find(params[:id])
			@rol = @rol.prev(@rol.id)
		end
		end
	end
  end
  
  def create
    xuser = current_user
	if signed_granted?(xuser.id, 'roles', 'N')
		@rol = Rol.new(params[:rol])
		@rol.menu_cod = $menugral
		@rol.created_by = xuser.login
		
		respond_to do |format|
			if @rol.save
				format.html { render action: "edit", notice: 'Creado satisfactoriamente.' }
				format.json { render json: @rol, status: :created, location: @rol }
			else
				format.html { render action: "new" }
				format.json { render json: @rol.errors, status: :unprocessable_entity }
		  end
		end
	end
  end

 def update
    xuser = current_user
	if signed_granted?(xuser.id, 'roles', 'E')
		@rol = Rol.find(params[:id])
		if (@rol.menu_cod.empty?) or (@rol.menu_cod.rstrip == '')
		 @rol.menu_cod = $menugral
		end 
		@rol.updated_by = xuser.login
		
		id = params[:id]
		if params[:rol_cabeza] && params[:rol_cabeza]["tmprolesdet"]
			maestro = params[:rol_cabeza]["tmprolesdet"]
		end
		
		acceder = '0'
		crear = '0'
		consultar = '0'
		actualizar = '0'
		eliminar = '0'
		activado_ono = '0'
		sql= ActiveRecord::Base.connection.execute("DELETE FROM roles_det WHERE rol_id = #{id}")
		if not maestro == nil
			maestro.each do |m|
				if m[1]["acceder"] == "on"
					acceder = '1'
				else	
					acceder = '0'
				end
				if m[1]["activo_desactivado"] == "on"
					activado_ono = '1'
				else	
					activado_ono = '0'
				end
				if m[1]["crear"] == "on"
					crear = '1'
				else	
					crear = '0'
				end
				if m[1]["consultar"] == "on"
					consultar = '1'
				else
					consultar = '0'
				end
				if m[1]["actualizar"] == "on"
					actualizar = '1'
				else	
					actualizar = '0'
				end
				if m[1]["eliminar"] == "on"
					eliminar = '1'
				else
					eliminar = '0'
				end	
				#puts "ACCEDER " + acceder + " |CREAR " + crear + " |CONSULTAR " + consultar + " |ACTUALIZAR " + actualizar + " |ELIMINAR " + eliminar 
				roldet = Roldet.new
				roldet.rol_id     = id
				roldet.controller = m[1]["controller"]
				roldet.acceder    = acceder 
				roldet.crear      = crear
				roldet.actualizar = actualizar
				roldet.consultar  = consultar
				roldet.eliminar   = eliminar
				roldet.save 
				#sql= ActiveRecord::Base.connection.execute("INSERT INTO roles_det(rol_id, controller, acceder, crear, consultar, actualizar, eliminar)
				#											VALUES(#{id}, '#{m[1]["controller"]}', '#{acceder}', '#{crear}', '#{consultar}', '#{actualizar}', '#{eliminar}')")
			end
		end
		respond_to do |format|
			if @rol.update_attributes(params[:rol])
				format.html { redirect_to edit_rol_path, notice: 'Se ha actualizado correctamente' }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @rol.errors, status: :unprocessable_entity }
			end
		end
	end
 end

=begin
	def destroy
	@rol = Rol.find(params[:id])
	@rol.destroy
    respond_to do |format|
		format.html { redirect_to roles_url }
		format.json { head :no_content }
    end
  end
=end
end
