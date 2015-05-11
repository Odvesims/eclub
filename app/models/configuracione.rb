class Configuracione < ActiveRecord::Base
	default_scope order: 'id'   
	attr_accessible :modalidad, :deboxional_year
	self.table_name = "configuraciones"  
end
