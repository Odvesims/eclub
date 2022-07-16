class Zona < ActiveRecord::Base
	self.table_name = "zonas"
	has_many :distritos
	has_many :iglesias  
	has_many :iglesiasclubes

	def next(id) 
		fila = Zona.where("id > #{id}").first
		if fila == nil
			self
		else
			fila
		end
	end

	def prev(id)
		fila = Zona.where("id < #{id}").last
		if fila == nil
			self
		else
			fila
		end	
	end

	def adventurers_club
	  filtered_clubs(1)
	end

	def pathfinders_clubs
	  filtered_clubs(2)
	end

	def master_guides_clubs
	  filtered_clubs(3)
	end

	def vailable_adventurers_club
	  available_churches(1)
	end

	def available_pathfinders_clubs
	  available_churches(2)
	end

	def available_master_guides_clubs
	  available_churches(3)
	end

	def filtered_clubs(club_type)
		Iglesiasclube.where("iglesiasclubes.zona_id = #{self.id} AND clubestipo_id = #{club_type}").all
	end

	def available_churches(club_type)
		Iglesia.where("iglesias.zona_id = #{self.id} AND id NOT IN (SELECT iglesia_id FROM iglesiasclubes WHERE clubestipo_id = #{club_type})").all
	end

	def accessUser
		user = User.where("id IN (SELECT user_id FROM users_defaults WHERE access_level = 'ZN' AND access_id = #{self.id})").first
		if user == nil
			return "<button class = 'btn btn-secondary' type = 'button' onClick='generateZoneUser(this, #{self.id})'>Generar Usuario</button>".html_safe
		else
			return "<button class = 'btn btn-success' type = 'button' onClick='viewUser(`#{user.login}`, `#{user.plain_text_initial_password}`)'>Ver Usuario</button>".html_safe
		end
	end

end
