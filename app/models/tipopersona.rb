class Tipopersona < ActiveRecord::Base
	default_scope order: 'id'
	attr_accessible :nombre
	self.table_name = "tipo_personas"  
end

