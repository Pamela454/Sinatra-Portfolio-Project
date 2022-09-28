# frozen_string_literal: true

class CreatePhysiciansTable < ActiveRecord::Migration[5.2]
  def change
    create_table :physicians do |column|
      column.string :username
      column.string :password
      column.integer :npi
      column.string :password_digest
    end
  end
end
