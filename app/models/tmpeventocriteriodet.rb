class Tmpeventocriteriodet < ActiveRecord::Base
	default_scope order: 'camporeeseventoscriteriosdet_id'
	attr_accessible :camporeeseventoscriterioscab_id, :camporeeseventoscriteriosdet_id, :evento_id, :detalle_nombre, :puntos_criterio_det 
	self.table_name = "tmp_eventocriterios_dets"  
end
