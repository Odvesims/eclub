class Sessionsopen < ActiveRecord::Base

  attr_accessor :remember_token, :login, :device, :timeout_limit, :created_at, :updated_at, :msgerror
  attr_accessor :msgerror

  self.table_name = "sessions_open"

  #validates :remember_token, :device,
        #           presence: true, uniqueness:{message:" No pueden haber dos i$

  #before_save :create_remember_token
end

