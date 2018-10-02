class Patient < ActiveRecord::Base
  validate :username_validator #symbol pointing to a method, won't save if there is an error 
  has_secure_password    #hash with salt using bcrypt gem. gives attribute of password_digest. contains authenticate method.
  belongs_to :physician

  validates :username, :presence => true, :uniqueness => true
  validates :password, :presence => true
  validates :medical_history, :presence => true
  validates :active_problems, :presence => true

  def username_validator #adding single validator method
    if Physician.username_taken?(self.username)  #shows error if evaluates to true
      self.errors[:username] << "is already taken"
    end
  end

end
