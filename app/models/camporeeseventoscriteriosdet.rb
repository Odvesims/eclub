class Camporeeseventoscriteriosdet < ActiveRecord::Base
	self.table_name = "camporeeseventoscriteriosdets" 
	belongs_to :camporeeseventocriterioscab
end
