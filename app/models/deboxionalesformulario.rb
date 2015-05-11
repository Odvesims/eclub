class Deboxionalesformulario < ActiveRecord::Base
	default_scope order: 'dia'   
	attr_accessible :fecha, :fecha_dia, :titulo, :versiculo, :cuerpo, :autor, :dia, :anio, :cita
	self.table_name = "deboxionales" 
		
	def self.search(search, page)
	  paginate :page => page,
			   :conditions => ['fecha_dia like ?', "%#{search}%"],
			   :order => 'dia'
	end

	def next(id) 
		fila = Deboxionalesformulario.where("id > #{id}").first
		if fila == nil
			self
		else
			fila
		end
	end

	def prev(id)
		fila = Deboxionalesformulario.where("id < #{id}").last
		if fila == nil
			self
		else
			fila
		end	
	end
end
