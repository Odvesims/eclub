class Zona < ActiveRecord::Base
	default_scope order: 'campo_id, zona_id'
	attr_accessible :campo_id, :zona_id,  :nombre
	self.table_name = "zonas"  
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
end
