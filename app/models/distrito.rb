class Distrito < ActiveRecord::Base
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
		zona.zona_id
	end
end
