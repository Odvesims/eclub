class Usersdefault < ActiveRecord::Base
  default_scope order: 'id'  
  belongs_to :users, foreign_key: "user_id"
  attr_accessible :user_id, :campo_id, :camporee_id, :zona_id, :distrito_id, :iglesia_id, :iglesiasclube_id, :access_level, :access_id
  self.table_name="users_defaults"
                   
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