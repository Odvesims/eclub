class Rol < ActiveRecord::Base
  has_many :roldet
  self.table_name = "roles" 
  validates :nombre_rol, :presence => true
  validates :descripcion, :presence => true,  
						:length => { :minimum => 0, :maximum => 30 }
 
   accepts_nested_attributes_for :roldet, :reject_if => :all_blank, :allow_destroy => true

							 
  def next(id)
    fila = Rol.where("id > ? ", id).first
	if fila == nil
	  self
	else
	  fila
	end
  end

  def prev(id)
    fila = Rol.where("id < ?", id).last
	if fila == nil
	  self
	else
	  fila
	end
	
  end
  
  def first
    fila = Rol.first
	if fila == nil
	  self
	else
	  fila
	end
  end
  
  def last
    fila = Rol.last
	if fila == nil
	  self
	else
	  fila
	end
  end
end
