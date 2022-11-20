# frozen_string_literal: true

class Measurement < ActiveRecord::Base
    belongs_to :patient
  
  end