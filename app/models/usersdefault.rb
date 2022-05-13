class Usersdefault < ActiveRecord::Base
  belongs_to :users, foreign_key: "user_id"
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

	def zone_name
		zona = Zona.find(self.zona_id)
		"#{zona.nombre}"
	end
end