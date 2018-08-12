class CreatePhysiciansTable < ActiveRecord::Migration

  def change
    create_table :physicians do |column|
      column.string :username
      column.string :password
      column.integer :npi
      column.string :password_digest
    end
  end

end
