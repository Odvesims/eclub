class Camporeeseventoscriteriosdet < ActiveRecord::Base
	default_scope order: 'camporeeseventoscriterioscab_id, id'
	attr_accessible :camporeeseventoscriterioscab_id, :nombre, :puntos, :camporeesevento_id
	self.table_name = "camporeeseventoscriteriosdets" 
	belongs_to :camporeeseventocriterioscab
end
