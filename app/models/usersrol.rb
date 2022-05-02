class Usersrol < ActiveRecord::Base
  belongs_to :user
  attr_accessor :rol_id, :user_id

  self.table_name = "users_roles"
end