class Camporeesrenglone < ActiveRecord::Base
	self.table_name = "camporeesrenglones"  

	has_many :camporeeseventos

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
