class User < ActiveRecord::Base
	has_many :usersrol
	has_one :usersdefault
	accepts_nested_attributes_for :usersrol, :reject_if => :all_blank, :allow_destroy => true
	accepts_nested_attributes_for :usersdefault, :reject_if => :all_blank, :allow_destroy => true
	has_secure_password
	self.table_name = "users"
	before_save { |user| user.email = email.downcase }
	before_save :create_remember_token
	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
	validates :login, presence:   true,
                    uniqueness: { case_sensitive: false }					
	#validates :password, presence: true, length: { minimum: 6 }, :on => :create
	#validates :password_confirmation, presence: true, :on => :create
	#after_validation { self.errors.messages.delete(:password_digest) }

	scope :order_by_zone, -> { joins(:usersdefault).order("users_defaults.zona_id ASC") }

	def default_conference
		self.usersdefault.campo_id
	end
  
	def default_camporee
		self.usersdefault.camporee_id
	end
	
	def club_type
		self.usersdefault.club_type
	end
	
	def accesId
		return self.usersdefault.access_id
	end
	
	def default_level(controller)
		access_level = self.usersdefault.access_level
		access_id = self.usersdefault.access_id
		return_string = ""
		case access_level
			when 'AD'
				case controller
					when 'campos'
						return_string = "id = #{access_id}"
					else
						return_string = "campo_id = #{self.default_conference}"
				end
			when 'CP'
				case controller
					when 'campos'
						return_string = "id = #{access_id}"
					else
						return_string = "campo_id = #{self.default_conference}"
				end
			when 'CF'
				return_string = "campo_id = #{access_id}"
			when 'ZN'
				case controller
					when 'campos'
						return_string = "id = #{self.default_conference}"
					when 'reporteporzonas'
						return_string = "campo_id = #{self.default_conference} AND id = #{access_id}"
					else 
						return_string = "campo_id = #{self.default_conference} AND zona_id = #{access_id}"
				end
			when 'DT'
				distrito = Distrito.find(access_id)
				case controller
					when 'campos'
						return_string = "id = #{self.default_conference}"
					when 'zonas'
					
					else 
						return_string = "campo_id = #{self.default_conference} AND zona_id = #{distrito.zona_id} AND distrito_id = #{access_id}"
				end
			when 'CH'
				iglesia = Iglesia.find(access_id)
				case controller
					when 'campos'
						return_string = "id = #{self.usersdefault.default_conference}"
					when 'zonas'
						return_string = "campo_id = #{self.default_conference} AND zona_id = #{iglesia.zona_id}"
					when 'distritos'
						return_string = "campo_id = #{self.default_conference} AND zona_id = #{iglesia.zona_id} AND distrito_id = #{iglesia.distrito_id}"
					else 
						return_string = "campo_id = #{self.default_conference} AND zona_id = #{iglesia.zona_id} AND distrito_id = #{iglesia.distrito_id} AND iglesia_id = #{access_id}"
				end
			when 'LC'
				iglesiaclub = Iglesiasclube.find(access_id)
				case controller
					when 'campos'
						return_string = "id = #{self.default_conference}"
					when 'zonas'
						return_string = "campo_id = #{self.default_conference} AND zona_id = #{iglesiaclub.zona_id}"
					when 'distritos'
						return_string = "campo_id = #{self.default_conference} AND zona_id = #{iglesiaclub.zona_id} AND distrito_id = #{iglesiaclub.distrito_id}"
					when 'iglesias' 
						return_string = "campo_id = #{self.default_conference} AND zona_id = #{iglesiaclub.zona_id} AND distrito_id = #{iglesiaclub.distrito_id} AND iglesia_id = #{iglesiaclub.iglesia_id}"
					else 
						return_string = "campo_id = #{self.default_conference} AND zona_id = #{iglesiaclub.zona_id} AND distrito_id = #{iglesiaclub.distrito_id} AND iglesia_id = #{iglesiaclub.iglesia_id} AND id = #{access_id}"
				end
		end
		return return_string
	end
	
	def next(id)
		fila = User.where("id > ? ", id).first
		if fila == nil
			self
		else
			fila
		end
	end

	def prev(id)
		fila = User.where("id < ?", id).last
		if fila == nil
			self
		else
			fila
		end
	end
  
	def first
		fila = User.first
		if fila == nil
			self
		else
			fila
		end
	end
  
	def last
		fila = User.last
		if fila == nil
			self
		else
			fila
		end
	end
  
	private

    def create_remember_token
		self.remember_token = SecureRandom.urlsafe_base64
    end
end
