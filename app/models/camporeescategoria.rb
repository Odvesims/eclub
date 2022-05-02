class Camporeescategoria < ActiveRecord::Base
	attr_accessor :camporee_id, :nombre, :min_puntos, :max_puntos
	self.table_name = "camporeescategorias"  
end
