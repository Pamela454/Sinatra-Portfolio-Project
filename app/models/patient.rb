class Patient < ActiveRecord::Base
  belongs_to :physician

  validates :username, :presence => true, :uniqueness => true
  validates :password, :presence => true

end
