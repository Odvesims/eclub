class Iglesium < ApplicationRecord

	def distrito_nombre
		distrito = Distrito.where("id = #{self.distrito_id}").first
		distrito_nombre = distrito.nombre
	end
	
	def next(id) 
		fila = Iglesium.where("id > #{id}").first
		if fila == nil
			self
		else
			fila
		end
	end

	def prev(id)
		fila = Iglesium.where("id < #{id}").last
		if fila == nil
			self
		else
			fila
		end	
	end
	
end
