class Usersdefault < ActiveRecord::Base
  default_scope order: 'id'
  belongs_to :userconf, foreign_key: "user_id"
  
  attr_accessible :setma_id, :divem_id, :caja_id

  self.table_name="users_defaults"
  validates :setma_id, :presence => true
  validates :divem_id, :presence => true  
  validates :caja_id, :presence => true 
                   
def next(id)
    fila = Usersdefault.where("id > ? ", id).first
	if fila == nil
	  self
	else
	  fila
	end
  end

  def prev(id)
    fila = Usersdefault.where("id < ?", id).last
	if fila == nil
	  self
	else
	  fila
	end
	
  end
  
  def first
    fila = Usersdefault.first
	if fila == nil
	  self
	else
	  fila
	end
  end
  
  def last
    fila = Usersdefault.last
	if fila == nil
	  self
	else
	  fila
	end
  end
end