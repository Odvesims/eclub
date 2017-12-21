class Datadeboxionale < ActiveRecord::Base
	default_scope order: 'id'   
	attr_accessible :id, :fecha, :fecha_dia, :titulo, :versiculo, :cuerpo, :autor, :dia, :anio, :cita, :idioma
	self.table_name = "deboxionales"  
		
	def next(id) 
		fila = Datadeboxionale.where("id > #{id}").first
		if fila == nil
			self
		else
			fila
		end
	end

	def prev(id)
		fila = Datadeboxionale.where("id < #{id}").last
		if fila == nil
			self
		else
			fila
		end	
	end
	
	def self.group_by_year
		select('DISTINCT ON (anio) *').order("anio DESC")
	end
end