class UsersdefaultsController < ApplicationController
	# GET /userdefaults
	# GET /userdefaults.json
	require 'json'
	def index
		if signed_granted?(current_user.id, 'usersdefaults','I')
			@userconfs = Userconf.all
    
			respond_to do |format|
				format.html # index.html.erb
				format.json { render json: @usersdefaults }
			end
		end
	end	

	# GET /userdefaults/1
	# GET /userdefaults/1.json
	def show
		if signed_granted?(current_user.id, 'usersdefaults','I')
			@function = params[:execfunction]
			if @function == 'borrardivem'
				@divem = Usersdivem.where("user_id = #{params[:user_id]} AND divem_id = #{params[:divem_id]}").first
				@divem.destroy
			else
				@users = User.all
				@userconfs = Userconf.all
				@usersdefaults = Usersdefault.find(params[:id])
				@userstipodocus = Userstipodocu.where("user_id=#{@usersdefault.user_id}")
				@tipodocumento_id = @userstipodocus.tipodocumento_id	
			end																																				
			respond_to do |format|
				format.html # show.html.erb
				format.json { render json: @usersdefaults }
			end
		end
	end
	
	# GET /userdefaults/1/edit
	def edit
		if signed_granted?(current_user.id, 'usersdefaults','E')
			ActiveRecord::Base.connection.execute("CREATE TEMP TABLE IF NOT EXISTS tmp_users_divems(id integer, divem_id integer, user_id integer, descripcion character varying, divemscategoria_id integer)") 
			ActiveRecord::Base.connection.execute("DELETE FROM tmp_users_divems;") 
			ActiveRecord::Base.connection.execute("INSERT INTO tmp_users_divems(id, divem_id, user_id, descripcion, divemscategoria_id) SELECT a.divem_id, a.user_id, a.divem_id, b.descripcion, b.divemscategoria_id FROM users_divems a, divems b WHERE a.user_id = #{current_user.id} AND b.id = a.divem_id") 
			@divems_prestamos = Tmpusersdivem.where("divemscategoria_id = 1").all
			@divems_inmboliarias = Tmpusersdivem.where("divemscategoria_id = 2").all 
			@divems_simcards = Tmpusersdivem.where("divemscategoria_id = 3").all 
			@divems_all = Tmpusersdivem.all
			@usersdefault = Usersdefault.find(params[:id]) 
			@userconf = Userconf.find(params[:id])
			@userstipodocu = Userstipodocu.where("user_id=#{@usersdefault.user_id}")
			@tipodocumento_id = @usersdefault.user_id 
			if @userconf.usersdefault == nil
				@userconf.Usersdefault.new
			end
			if @userconf.usersdefpre == nil
				@userconf.usersdefpre.new
			end
			if @userconf.userstipodocu == nil
				@userconf.userstipodocu.new
			end	
			@divems = Divem.all
			@cajas = Caja.all
			@setmas = Setma.all
			@tipodocumentos = Tipodocumento.all

			if params[:donde] == 'next'
				@userconf = Userconf.find(params[:id])
				@userconf = @userconf.next(@userconf.id)
			else if params[:donde] == 'prev'
					@userconf = Userconf.find(params[:id])
					@userconf = @userconf.prev(@userconf.id)
				end
			end
		end
	end	
  
	# POST /userdefaults
	# POST /userdefaults.json
	def create
		if signed_granted?(current_user.id, 'usersdefaults','N')
			@usersdefault = Usersdefault.new(params[:usersdefaults])
			@divems = Divem.all
			@cajas = Caja.all
			@setmas = Setma.all
			@userconfs = Userconf.all
			@tipodocumentos = Tipodocumento.all
			@usersdefpres = Usersdefpre.all
			@userstipodocus = Userstipodocu.all

			respond_to do |format|
				if @usersdefaults.save
					format.html { render action: "edit", notice: 'Creado satisfactoriamente.' }
					format.json { render json: @usersdefaults, status: :created, location: @usersdefaults }
				else
					format.html { render action: "new" }
					format.json { render json: @usersdefaults.errors, status: :unprocessable_entity }
				end
			end
		end
	end

	# PUT /userdefaults/1
	# PUT /userdefaults/1.json
	def update
		if signed_granted?(current_user.id, 'usersdefaults','I')
			@userconf = Userconf.find(params[:id])
			user = Usersdefault.find(params[:id])
			@divems = Divem.all
			@cajas = Caja.all
			@setmas = Setma.all
			@tipodocumentos = Tipodocumento.all
			los_divems = params[:los_divems]
			los_divems.gsub!(/([{,]\s*):([^>\s]+)\s*=>/, '\1"\2"=>')
			los_divems.gsub!(/([{,]\s*)([0-9]+\.?[0-9]*)\s*=>/, '\1"\2"=>')
			los_divems.gsub!(/([{,]\s*)(".+?"|[0-9]+\.?[0-9]*)\s*=>\s*:([^,}\s]+\s*)/, '\1\2=>"\3"')
			los_divems.gsub!(/([\[,]\s*):([^,\]\s]+)/, '\1"\2"')
			los_divems.gsub!(/([{,]\s*)(".+?"|[0-9]+\.?[0-9]*)\s*=>/, '\1\2:')
			los_divems = JSON.parse(los_divems)
			i = 0;
			divems = Usersdivem.where("user_id = #{user.user_id}").last
			indice_divem = divems.id
			if params[:users_divems] != nil
				if params[:users_divems][:financieras] != nil
					params[:users_divems][:financieras].each do |f|
						divem_existe = Usersdivem.where("divem_id = #{f[1]} AND user_id = #{user.user_id}").first
						if divem_existe == nil
							indice_divem += 1
							userdivem = Usersdivem.new
							userdivem.id = indice_divem
							userdivem.user_id = user.user_id
							userdivem.divem_id = f[1].to_i
							userdivem.save
						end
					end
				end
				if params[:users_divems][:inmobiliarias] != nil
					params[:users_divems][:inmobiliarias].each do |i|
						divem_existe = Usersdivem.where("divem_id = #{i[1]} AND user_id = #{user.user_id}").first
						if divem_existe == nil
							indice_divem += 1
							userdivem = Usersdivem.new
							userdivem.id = indice_divem
							userdivem.user_id = user.user_id
							userdivem.divem_id = i[1].to_i
							userdivem.save
						end
					end
				end
				if params[:users_divems][:simcards] != nil
					params[:users_divems][:simcards].each do |s|
						divem_existe = Usersdivem.where("divem_id = #{s[1]} AND user_id = #{user.user_id}").first
						if divem_existe == nil
							indice_divem += 1
							userdivem = Usersdivem.new
							userdivem.id = indice_divem
							userdivem.user_id = user.user_id
							userdivem.divem_id = s[1].to_i
							userdivem.save
						end
					end	
				end
			end
			respond_to do |format|
				if @userconf.update_attributes(params[:userconf])
					format.html { redirect_to edit_usersdefault_path, notice: 'Se ha actualizado correctamente' }
					format.json { head :no_content }
				else
					format.html { render action: "edit" }
					format.json { render json: @userconf.errors, status: :unprocessable_entity }
				end
			end
		end
	end

	# DELETE /userdefaults/1
	# DELETE /userdefaults/1.json
	def destroy
		if signed_granted?(current_user.id, 'usersdefaults','D')
			@usersdefault = Usersdefault.find(params[:id])
			@usersdefault.destroy

			respond_to do |format|
				format.html { redirect_to usersdefaults_url }
				format.json { head :no_content }
			end
		end
	end
end