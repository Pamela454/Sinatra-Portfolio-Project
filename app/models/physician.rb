class Physician < ActiveRecord::Base
  #validate :username_validator #symbol pointing to a method, wont save if there is an error
  has_secure_password
  has_many :patients

  validates :username, :presence => true, :uniqueness => true
  validates :npi, :presence => true, :uniqueness => true, length: 10
  validates :password, :presence => true

  def self.username_taken?(username) #method does not belong to an instance of the class
    @patients = Patient.all
    @physicians = Physician.all

    @patients.each { |patient| patient.username == username } &&
    @physicians.each { |physician| physician.username == username }
  end #returns true if username already taken

  #def username_validator
   # if Physician.username_taken?(self.username)  #shows error if evaluates to true
    #  self.errors[:username] << "is already taken"
    #end
  #end

end
