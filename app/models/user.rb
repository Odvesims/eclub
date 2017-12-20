class User < ActiveRecord::Base
  has_many :usersrol
  accepts_nested_attributes_for :usersrol, :reject_if => :all_blank, :allow_destroy => true
  
  attr_accessible :usersrol_attributes, :login, :name, :email, :password, :password_confirmation, :menu_cod, :idioma_isocod2, :idioma_id, :estatus
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
  validates :password, presence: true, length: { minimum: 6 }, :on => :create
  validates :password_confirmation, presence: true, :on => :create
  after_validation { self.errors.messages.delete(:password_digest) }

  def default_divem
   self.usersdefault.divem_id
  end
  
  def default_setma
   self.usersdefault.setma_id
  end
  
  def default_caja
   self.usersdefault.caja_id
  end

  
  #retorna la condicion sql para filtrar las divems autorizadas al usuario para hacer transacciones
  def condicion_divem
    resu = ' '
	ldivems = self.usersdivem
    if ldivems.count == 0 
	   resu = "divem_id = #{self.usersdefault.divem_id} "
	else
	   lc = 0
	   resu = "divem_id in ("
	   ldivems.each do |di|
	     if lc != 0 
		  resu += ","
		 end
	     resu += "#{di.divem_id}" 
		 lc +=1
	   end
	   resu += ")"
	end
	resu
  end
  
  #retorna filtradas las divems autorizadas que puede seleccionar el usuario
  def select_divem
    resu = ' '
	ldivems = self.usersdivem
    if ldivems.count == 0 
	   resu = "id = #{self.usersdefault.divem_id} "
	else
	   lc = 0
	   resu = "id in ("
	   ldivems.each do |di|
	     if lc != 0 
		  resu += ","
		 end
	     resu += "#{di.divem_id}" 
		 lc +=1
	   end
	   resu += ")"
	end
	resu
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
