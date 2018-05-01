class Camporeeseventoscriterioscab < ActiveRecord::Base
	default_scope order: 'camporeesevento_id, id'
	attr_accessible :camporeesevento_id, :nombre, :total_puntos
	self.table_name = "camporeeseventoscriterioscabs" 
	belongs_to :camporeesevento
	has_many :camporeeseventoscriteriosdets
	accepts_nested_attributes_for :camporeeseventoscriteriosdets, :allow_destroy => true
	
	def zonaId
		zona = Zona.find(self.zona_id)
		return zona.zona_id
	end
end
