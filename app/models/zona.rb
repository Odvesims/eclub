class Zona < ActiveRecord::Base
	self.table_name = "zonas"  
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
end
