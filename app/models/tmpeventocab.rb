class Tmpeventocab < ActiveRecord::Base
	default_scope order: 'renglon_id, evento_id'
	attr_accessor :camporee_id, :renglon_id, :evento_id, :evento_nombre, :participantes, :tiempo, :total_puntos, :renglon_nombre 
	self.table_name = "tmp_eventocabezera"  
end
