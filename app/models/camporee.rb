class Camporee < ActiveRecord::Base
	self.table_name = "camporees"  

	def campo_nombre
		campo = Campo.find(self.campo_id)
		campo_nombre = campo.nombre
	end

	def camporee_tipo
		tipo = Clubestipo.find(self.clubestipo_id)
		camporee_tipo = tipo.nombre
	end
	
	def next(id) 
		fila = Camporee.where("id > #{id}").first
		if fila == nil
			self
		else
			fila
		end
	end

	def prev(id)
		fila = Camporee.where("id < #{id}").last
		if fila == nil
			self
		else
			fila
		end	
	end
end
