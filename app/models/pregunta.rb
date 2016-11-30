class Pregunta < ActiveRecord::Base
	default_scope order: 'id'   
	attr_accessible :pregunta, :respuesta, :cita, :preguntada, :usada, :visible
	self.table_name = "preguntas" 
end
