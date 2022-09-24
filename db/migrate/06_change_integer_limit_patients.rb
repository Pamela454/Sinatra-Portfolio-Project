class ChangeIntegerLimitPatients < ActiveRecord::Migration[5.2]
    def change
      change_column :patients, :patient_id, :integer, limit: 8
    end 
  end