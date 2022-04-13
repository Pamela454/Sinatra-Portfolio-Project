class Patient < ActiveRecord::Base
  has_secure_password    
  belongs_to :physician

  validates :username, :presence => true, :uniqueness => true
  validates :password, :presence => true
  validates :medical_history, :presence => true
  validates :active_problems, :presence => true
end
