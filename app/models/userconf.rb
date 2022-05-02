class Userconf < ActiveRecord::Base
  has_one :usersdefault, foreign_key: "user_id"
  has_many :usersdefpre, foreign_key: "user_id"
  has_many :userstipodocu, foreign_key: "user_id"
  has_many :setma
  has_many :usersdivem, foreign_key: "user_id"
  has_many :userssetma, foreign_key: "user_id"
  accepts_nested_attributes_for :setma, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :usersdivem, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :userssetma, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :usersdefault, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :userstipodocu, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :usersdefpre, :reject_if => :all_blank, :allow_destroy => true
 
  self.table_name = "users"
 
  #before_save { |user| user.email = email.downcase }
  #before_save :create_remember_token
  
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  
   def next(id)
    fila = Userconf.where("id > ? ", id).first
	if fila == nil
	  self
	else
	  fila
	end
  end

  def prev(id)
    fila = Userconf.where("id < ?", id).last
	if fila == nil
	  self
	else
	  fila
	end
  end
  
end