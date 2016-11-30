class Equipo < ActiveRecord::Base
	default_scope order: 'id'   
	attr_accessible :nombre, :puntuacion, :activo
	self.table_name = "equipos" 
end
