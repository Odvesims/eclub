class Camporeesevento < ActiveRecord::Base
	self.table_name = "camporeeseventos"  
	has_many :camporeeseventoscriterioscabs
	has_many :camporeeseventoscriteriosdets, :through => :camporeeseventoscriterioscabs
	accepts_nested_attributes_for :camporeeseventoscriterioscabs, :allow_destroy => true
	accepts_nested_attributes_for :camporeeseventoscriteriosdets

	def campo_nombre
		campo = Campo.find(self.campo_id)
		campo_nombre = campo.nombre
	end

	def camporee_nombre
		camporee = Camporee.find(self.camporee_id)
		camporee_tipo = camporee.nombre
	end

	def renglon_nombre
		camporee_renglon = Camporeesrenglone.find(self.camporeesrenglone_id)
		renglon_nombre = camporee_renglon.nombre
	end
	
	def next(id) 
		fila = Camporeesevento.where("id > #{id}").first
		if fila == nil
			self
		else
			fila
		end
	end

	def prev(id)
		fila = Camporeesevento.where("id < #{id}").last
		if fila == nil
			self
		else
			fila
		end	
	end
end
