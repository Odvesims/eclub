class Cambiodata < ActiveRecord::Base
	attr_accessible :si_no, :version
	self.table_name = "cambio_data"  
end
