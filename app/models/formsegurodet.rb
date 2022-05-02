class Formsegurodet < ActiveRecord::Base
	attr_accessor :formsegurocab_id, :nombre, :sexo, :edad, :fecha_nacimiento, :nombre_tutor
	self.table_name = "formseguro_dets"  
	belongs_to :formsegurocab
end

