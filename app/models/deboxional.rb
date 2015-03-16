class Deboxional < ActiveRecord::Base
	default_scope order: 'id'   
	attr_accessible :id, :fecha, :dia_fecha, :titulo, :versiculo, :cuerpo, :autor, :dia, :anio, :cita
	self.table_name = "deboxionales"  
end
