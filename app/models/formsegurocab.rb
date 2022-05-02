class Formsegurocab < ActiveRecord::Base
	attr_accessor :union_id, :campo_id, :zona_id, :distrito_id, :iglesia_id, :iglesiasclube_id, :nombre_pastor, :fecha_desde, :fecha_hasta, :nombre_director
	self.table_name = "formseguro_cab"  
	has_many :formsegurodets
	accepts_nested_attributes_for :formsegurodets, :allow_destroy => true
end

