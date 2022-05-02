class Roldet < ActiveRecord::Base
  belongs_to :rol
  self.table_name = "roles_det" 
  validates :controller, uniqueness:{scope: :rol_id,
             message:" No puede haber un controller repetido " }

end
