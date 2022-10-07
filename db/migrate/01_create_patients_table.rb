# frozen_string_literal: true

class CreatePatientsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :patients do |column|
      column.string :username
      column.string :password
      column.string :password_digest
    end
  end
end
