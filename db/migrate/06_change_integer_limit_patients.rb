class ChangeIntegerLimitPatients < ActiveRecord::Migration[5.2]
    def change
      change_column :patients, :physician_id, :integer, limit: 8
      change_column :patients, :id, :integer, limit: 8 
    end 
  end