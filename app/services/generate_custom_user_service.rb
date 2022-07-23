class GenerateCustomUserService

  attr_accessor :login, :name, :password, :access_id, :access_level, :zone_id, :club_type, :default_camporee, :default_conference, :roles, :rol_id, :admin

  def initialize(service_params)
		@login = service_params[:login]
		@name = service_params[:name]
    @access_id = service_params[:access_id].to_i
		@access_level = service_params[:access_level]
    @default_camporee = service_params[:default_camporee]
    @default_conference = service_params[:default_conference]
		@roles = service_params[:roles]
		@rol_id = service_params[:rol_id]
		@password = service_params[:password]
		@admin = service_params[:admin]
		@zone_id = service_params[:zone_id]
		@club_type = service_params[:club_type]
  end

  def execute()
		begin
		  new_user = User.where("login = '#{login}'").first
			if new_user == nil
				new_user = User.new
				new_user.login = login
			end
			new_user.name = name
			new_user.email = "#{login}@noemail.com"
			new_user.admin = admin
			new_user.password_digest = password
			new_user.plain_text_initial_password = password
			new_user.idioma_isocod2 = 'es'
			new_user.idioma_id = 1
			new_user.menu_cod = 'ECLUBMENU'
			new_user.timeout_limit = 100
			if new_user.save!
				ActiveRecord::Base.logger.silence do
					ActiveRecord::Base.connection.execute("UPDATE users SET password_digest = crypt('#{password}', gen_salt('bf', 11)) WHERE id = #{new_user.id}")
				end
				user_defaults = Usersdefault.new
				user_defaults.user_id = new_user.id
				user_defaults.camporee_id = default_camporee
				user_defaults.campo_id = default_conference
				user_defaults.zona_id = zone_id
				user_defaults.access_level = access_level
				user_defaults.access_id = access_id
				user_defaults.club_type = club_type
				user_defaults.is_bicamporee = false
				user_defaults.access_all_events = false
				user_defaults.rol_id = rol_id
				user_defaults.zone_id = zone_id
				user_defaults.save!

				user_role = Usersrol.new
				user_role.user_id = new_user.id
				user_role.rol_id = rol_id
				user_role.save!

				roles.each do |rol|
					user_role = Usersrol.new
					user_role.user_id = new_user.id
					user_role.rol_id = rol["id"]
					user_role.save!
				end
			end
		  { valid: true, message: "Usuario Generado" }
	  rescue Exception => e
      Rails.logger.debug("Error: #{e.message}")
		  { valid: false, message: e.message }
	  end
  end
end