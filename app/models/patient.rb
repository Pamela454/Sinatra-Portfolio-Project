# frozen_string_literal: true

class Patient < ActiveRecord::Base
  has_secure_password
  has_many :measurements
  belongs_to :physician

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
end
