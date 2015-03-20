class Configuracione < ActiveRecord::Base
	default_scope order: 'id'   
	attr_accessible :modalidad
	self.table_name = "configuraciones"  
end
