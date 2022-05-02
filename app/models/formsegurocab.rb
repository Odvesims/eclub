class Formsegurocab < ActiveRecord::Base
	self.table_name = "formseguro_cab"  
	has_many :formsegurodets
	accepts_nested_attributes_for :formsegurodets, :allow_destroy => true
end

