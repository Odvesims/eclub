class Formmatriculadet < ActiveRecord::Base
	attr_accessible :formmatriculacab_id, :nombre, :sexo, :edad, :fecha_nacimiento, :nombre_tutor, :tipopersona_id
	self.table_name = "formmatricula_dets"  
	belongs_to :formmatriculacab
end

