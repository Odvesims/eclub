class Clubesarchivo < ActiveRecord::Base
	self.table_name = "clubesarchivos"  

	def camporee_nombre
		camporee = Camporee.find(self.camporee_id)
		camporee_nombre = camporee.nombre
	end
	
	def club_nombre
		club = Iglesiasclube.find(self.iglesiasclubes_id)
		club_nombre = club.nombre
	end
	
	def next(id) 
		fila = Clubesarchivo.where("id > #{id}").first
		if fila == nil
			self
		else
			fila
		end
	end

	def prev(id)
		fila = Clubesarchivo.where("id < #{id}").last
		if fila == nil
			self
		else
			fila
		end	
	end
end
