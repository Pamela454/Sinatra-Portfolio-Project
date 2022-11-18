# frozen_string_literal: true

class AddBloodpressureColumn < ActiveRecord::Migration[5.2]
    def change
      add_column :patients, :blood_pressure, :string
    end
end