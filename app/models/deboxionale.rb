class Deboxionale < ActiveRecord::Base
	default_scope order: 'dia'   
	attr_accessible :id, :fecha, :fecha_dia, :titulo, :versiculo, :cuerpo, :autor, :dia, :anio, :cita, :idioma
	self.table_name = "deboxionales"  
		
	def next(id) 
		fila = Deboxionale.where("id > #{id}").first
		if fila == nil
			self
		else
			fila
		end
	end

	def prev(id)
		fila = Deboxionale.where("id < #{id}").last
		if fila == nil
			self
		else
			fila
		end	
	end
end
