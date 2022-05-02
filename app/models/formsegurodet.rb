class Formsegurodet < ActiveRecord::Base
	self.table_name = "formseguro_dets"  
	belongs_to :formsegurocab
end

