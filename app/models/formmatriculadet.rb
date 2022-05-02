class Formmatriculadet < ActiveRecord::Base
	self.table_name = "formmatricula_dets"  
	belongs_to :formmatriculacab
	
	def tipo_persona
		tipo = Tipopersona.find(self.tipopersona_id)
		return tipo.nombre
	end
end

