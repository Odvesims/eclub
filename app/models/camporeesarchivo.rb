class Camporeesarchivo < ActiveRecord::Base
	self.table_name = "camporeesarchivos"  

	def camporee_nombre
		camporee = Camporee.find(self.camporee_id)
		camporee_nombre = camporee.nombre
	end
	
	def next(id) 
		fila = Camporeesarchivo.where("id > #{id}").first
		if fila == nil
			self
		else
			fila
		end
	end

	def prev(id)
		fila = Camporeesarchivo.where("id < #{id}").last
		if fila == nil
			self
		else
			fila
		end	
	end
end
