class Iglesia < ActiveRecord::Base
	self.table_name = "iglesias"  

	def distrito_nombre
		distrito = Distrito.where("id = #{self.distrito_id}").first
		distrito_nombre = distrito.nombre
	end
	
	def next(id) 
		fila = Iglesia.where("id > #{id}").first
		if fila == nil
			self
		else
			fila
		end
	end

	def prev(id)
		fila = Iglesia.where("id < #{id}").last
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
