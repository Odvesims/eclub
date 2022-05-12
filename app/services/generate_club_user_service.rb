class GenerateClubUserService

  attr_accessor :club_id, :club_pure_name, :zone_id, :club_type, :default_camporee, :default_conference

  def initialize(service_params)
    @club_id = service_params[:club_id].to_i
    @default_camporee = service_params[:default_camporee]
    @default_conference = service_params[:default_conference]
  end

  def execute()
    user_defaults = Usersdefault.where("access_level = 'LC' AND access_id = #{club_id}").first
    if(user_defaults != nil)
      return { valid: false, message: "Ya existe un usuario para este club" }
    end
    club = Iglesiasclube.find(club_id)
    @club_pure_name = club.nombre
    @zone_id = club.zona_id
    @club_type = club.clubestipo_id
    club_name = club_pure_name.split(" ")
		login = ""
		begin
			if club_name.length > 1
				club_name.each_with_index do |part, i| 
					if part.length <= 3 and i < club_name.length - 1
						login += part.to_s.downcase
					else
						login += part.to_s.downcase.parameterize
						break
					end
				end
			else
				login = club_pure_name.downcase.parameterize;
			end
			user_exists = false
			user = User.where("login = '#{login}'").first
			if user != nil
				user_exists = true
			end
			i = 1
			while user_exists == true 
				login = login + i.to_s
				user = User.where("login = '#{login}'").first
				if user == nil
					user_exists = false
				end
				i += 1
			end
			password = rand(100000..999999)
      Rails.logger.debug("Password : #{password}")
			new_user = User.new
			new_user.login = login
			new_user.name = club_pure_name
			new_user.email = "#{login}@noemail.com"
			new_user.admin = false
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
				user_defaults.access_level = 'LC'
				user_defaults.access_id = club_id
				user_defaults.club_type = club_type
				user_defaults.is_bicamporee = false
				user_defaults.access_all_events = false
				user_defaults.rol_id = 3
				user_defaults.zone_id = zone_id
				user_defaults.save!
			end
		  { valid: true, message: "" }
	  rescue Exception => e
      Rails.logger.debug("Error: #{e.message}")
		  { valid: false, message: e.message }
	  end
  end
end