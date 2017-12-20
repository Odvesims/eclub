class Usersrol < ActiveRecord::Base
  belongs_to :user
  attr_accessible :rol_id, :user_id

  self.table_name = "users_roles"
end