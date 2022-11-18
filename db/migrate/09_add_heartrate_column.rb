# frozen_string_literal: true

class AddHeartRateColumn < ActiveRecord::Migration[5.2]
    def change
      add_column :patients, :heart_rate, :integer
    end
  end