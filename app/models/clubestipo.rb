class Clubestipo < ActiveRecord::Base
	default_scope order: 'id'
	attr_accessible :nombre
	self.table_name = "clubestipos"  
end
