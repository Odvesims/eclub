class Formmatriculadet < ActiveRecord::Base
	attr_accessor :formmatriculacab_id, :nombre, :sexo, :edad, :fecha_nacimiento, :nombre_tutor, :tipopersona_id
	self.table_name = "formmatricula_dets"  
	belongs_to :formmatriculacab
	
	def tipo_persona
		tipo = Tipopersona.find(self.tipopersona_id)
		return tipo.nombre
	end
end

