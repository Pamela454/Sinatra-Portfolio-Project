# frozen_string_literal: true

class Physician < ActiveRecord::Base
  has_secure_password
  has_many :patients

  validates :username, presence: true, uniqueness: true
  validates :npi, presence: true, uniqueness: true, length: { is: 10 }
  validates :password, presence: true

  def self.username_taken?(username)
    @patients = Patient.all
    @physicians = Physician.all

    @patients.each { |patient| patient.username == username } &&
      @physicians.each { |physician| physician.username == username }
  end
end
