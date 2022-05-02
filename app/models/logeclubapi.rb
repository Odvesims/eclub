class Logeclubapi < ActiveRecord::Base
  attr_accessor :login, :username, :log_option, :log_action, :log_comment, :created_at, :origin
  self.table_name = "logeclubapi"
end
