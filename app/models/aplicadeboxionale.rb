class Aplicadeboxionale < ActiveRecord::Base
	default_scope order: 'id'   
	attr_accessible :id, :titulo, :versiculo, :cuerpo, :autor, :contacto, :email, :iglesia
	validates :titulo, presence: {message:"no puede quedar en blanco"}, :on => :create
	validates :versiculo, presence: {message:"no puede quedar en blanco"}, :on => :create
	validates :cuerpo, :length => {
		:minimum   => 300,
		:maximum   => 300,
		:tokenizer => lambda { |str| str.scan(/\w+/) },
		:too_short => "debe tener al menos %{count} palabras.",
		:too_long  => "no puede exceder las %{count} palabras."
	  }, :on => :create
	validates :autor, presence: {message:"no puede quedar en blanco"}, :on => :create
	validates :iglesia, presence: {message:"no puede quedar en blanco"}, :on => :create
	validates :contacto, presence: {message:"no puede quedar en blanco"}, :on => :create
	
	self.table_name = "aplica_deboxionales"  
		
	def next(id) 
		fila = Aplicadeboxionale.where("id > #{id}").first
		if fila == nil
			self
		else
			fila
		end
	end

	def prev(id)
		fila = Aplicadeboxionale.where("id < #{id}").last
		if fila == nil
			self
		else
			fila
		end	
	end
end
