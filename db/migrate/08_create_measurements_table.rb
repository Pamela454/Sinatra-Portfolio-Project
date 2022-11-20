# frozen_string_literal: true

class CreateMeasurementsTable < ActiveRecord::Migration[5.2]
    def change
      create_table :measurements do |column|
        column.string :blood_pressure
        column.integer :heart_rate
        column.datetime :date_time
        column.integer :patient_id 
      end
    end
  end