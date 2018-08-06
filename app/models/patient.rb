class Patient < ActiveRecord::Base
  belongs_to :doctor

  validates :username, :presence => true, :uniqueness => true
  validates :password, :presence => true, :length { minimum: 5 }

end
