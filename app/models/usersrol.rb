class Usersrol < ActiveRecord::Base
  belongs_to :user
  self.table_name = "users_roles"
end