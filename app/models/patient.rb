class Patient < ActiveRecord::Base
  has_secure_password    #hash with salt using bcrypt gem. gives attribute of password_digest. contains authenticate method.
  belongs_to :physician

  validates :username, :presence => true, :uniqueness => true
  validates :password, :presence => true
  validates :medical_history, :presence => true
  validates :active_problems, :presence => true

class UserValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || "is not a patient")
  end

  #validate - rails guides - if/then statement?
end
