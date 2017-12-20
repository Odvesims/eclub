class Logdeboxionalapi < ActiveRecord::Base
  attr_accessible :login, :username, :log_option, :log_action, :log_comment, :created_at, :origin
  self.table_name = "logdeboxionalapi"
end
