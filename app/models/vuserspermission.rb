class Vuserspermission < ActiveRecord::Base
  attr_accessor :user_id, :controller, :crear, :consultar, :actualizar, :eliminar, :acceder
  self.table_name = "v_users_permission" 

end
