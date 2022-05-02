class Campo < ActiveRecord::Base
	self.table_name = "campos"  
	
	def next(id) 
		fila = Campo.where("id > #{id}").first
		if fila == nil
			self
		else
			fila
		end
	end

	def prev(id)
		fila = Campo.where("id < #{id}").last
		if fila == nil
			self
		else
			fila
		end	
	end
end
