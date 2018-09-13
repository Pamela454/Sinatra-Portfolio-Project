class Patient < ActiveRecord::Base
  has_secure_password    #hash with salt using bcrypt gem. gives attribute of password_digest. contains authenticate method. 
  belongs_to :physician

  validates :username, :presence => true, :uniqueness => true
  validates :password, :presence => true
  validates :medical_history, :presence => true
  validates :active_problems, :presence => true


end
