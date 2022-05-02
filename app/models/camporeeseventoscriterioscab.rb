class Camporeeseventoscriterioscab < ActiveRecord::Base
	self.table_name = "camporeeseventoscriterioscabs" 
	belongs_to :camporeesevento
	has_many :camporeeseventoscriteriosdets
	accepts_nested_attributes_for :camporeeseventoscriteriosdets, :allow_destroy => true
	
	def zonaId
		zona = Zona.find(self.zona_id)
		return zona.zona_id
	end
end
