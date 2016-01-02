class Cambiodata < ActiveRecord::Base
	attr_accessible :id, :si_no
	self.table_name = "cambio_data"  
end
