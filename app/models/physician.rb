class Physician < ActiveRecord::Base
  has_secure_password
  has_many :patients

  validates :username, :presence => true, :uniqueness => true
  validates :npi, :presence => true, :uniqueness => true
  validates :password, :presence => true, length: { minimum: 5 }

end
