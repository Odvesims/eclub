class Iglesiasclube < ActiveRecord::Base
	default_scope order: 'campo_id, zona_id, distrito_id, iglesia_id, clubestipo_id, nombre'
	attr_accessible :campo_id, :zona_id, :distrito_id, :iglesia_id, :clubestipo_id, :nombre
	self.table_name = "iglesiasclubes"  

	def tipo_nombre
		tipo = Clubestipo.find(self.clubestipo_id)
		tipo_nombre = tipo.nombre
	end
	
	def iglesia_nombre
		iglesia = Iglesia.find(self.iglesia_id)
		iglesia_nombre = iglesia.nombre
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
end
