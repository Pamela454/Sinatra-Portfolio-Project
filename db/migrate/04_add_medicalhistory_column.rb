# frozen_string_literal: true

class AddMedicalhistoryColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :patients, :medical_history, :string
  end
end
