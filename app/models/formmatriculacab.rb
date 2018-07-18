class Formmatriculacab < ActiveRecord::Base
	attr_accessible :union_id, :campo_id, :zona_id, :distrito_id, :iglesia_id, :iglesiasclube_id, :nombre_pastor, :fecha_desde, :fecha_hasta, :nombre_director
	self.table_name = "formmatricula_cab"  
	has_many :formmatriculadets
	accepts_nested_attributes_for :formmatriculadets, :allow_destroy => true
	
	def clubNombre
		club = Iglesiasclube.find(self.iglesiasclube_id)
		return club.nombre
	end
	
	def iglesiaNombre
		club = Iglesia.find(self.iglesia_id)
		return club.nombre
	end
end