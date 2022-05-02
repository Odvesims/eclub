class Tmpeventocriteriocab < ActiveRecord::Base
	default_scope order: 'camporeeseventoscriterioscab_id'
	attr_accessor :camporeeseventoscriterioscab_id, :camporeesevento_id, :criterio_nombre, :puntos_criterio_cab 
	self.table_name = "tmp_eventocriterios_cab"  
end
