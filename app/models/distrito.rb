class Distrito < ActiveRecord::Base
	default_scope order: 'campo_id, zona_id'
	attr_accessible :campo_id, :zona_id, :pastor_id, :nombre
	self.table_name = "distritos"  
	def next(id) 
		fila = Distrito.where("id > #{id}").first
		if fila == nil
			self
		else
			fila
		end
	end

	def prev(id)
		fila = Distrito.where("id < #{id}").last
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
