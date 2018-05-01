class Camporeesrenglone < ActiveRecord::Base
	default_scope order: 'camporee_id, id'
	attr_accessible :camporee_id, :total_puntos, :nombre, :color
	self.table_name = "camporeesrenglones"  

	def camporee_nombre
		camporee = Camporee.find(self.camporee_id)
		camporee_nombre = camporee.nombre
	end
	
	def next(id) 
		fila = Camporeesrenglone.where("id > #{id}").first
		if fila == nil
			self
		else
			fila
		end
	end

	def prev(id)
		fila = Camporeesrenglone.where("id < #{id}").last
		if fila == nil
			self
		else
			fila
		end	
	end
end
