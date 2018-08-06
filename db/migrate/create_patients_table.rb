class CreatePatientsTable < ActiveRecord::Migration

  def change
    create_table :patients do |column|
      column.string :username
      column.string :password
      column.string :password_digest
    end
  end

end
