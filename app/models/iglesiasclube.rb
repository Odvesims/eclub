class Iglesiasclube < ActiveRecord::Base
	self.table_name = "iglesiasclubes"  

	def tipo_nombre
		tipo = Clubestipo.find(self.clubestipo_id)
		tipo_nombre = tipo.nombre
	end
	
	def iglesia_nombre
		begin
		iglesia = Iglesia.find(self.iglesia_id)
		iglesia_nombre = iglesia.nombre
		rescue
			""
		end
	end
	
	def distrito_nombre
		distrito = Distrito.find(self.distrito_id)
		distrito_nombre = distrito.nombre
	end
	
	def next(id) 
		fila = Iglesiasclube.where("id > #{id}").first
		if fila == nil
			self
		else
			fila
		end
	end

	def prev(id)
		fila = Iglesiasclube.where("id < #{id}").last
		if fila == nil
			self
		else
			fila
		end	
	end
	
	def zonaId
		zona = Zona.find(self.zona_id)
		return zona.zona_id
	end

	def zonaNombre
		zona = Zona.find(self.zona_id)
		return zona.nombre
	end

	def zonaSigla
		zona = Zona.find(self.zona_id)
		return zona.zona_siglas
	end

	def accessUser
		user = User.where("id IN (SELECT user_id FROM users_defaults WHERE access_level = 'LC' AND access_id = #{self.id})").first
		if user == nil
			return "<button class = 'btn btn-secondary' type = 'button' onClick='generateClubUser(this, #{self.id})'>Generar Usuario</button>".html_safe
		else
			return "<button class = 'btn btn-success' type = 'button' onClick='viewUser(`#{user.login}`, `#{user.plain_text_initial_password}`)'>Ver Usuario</button>".html_safe
		end
	end
end
