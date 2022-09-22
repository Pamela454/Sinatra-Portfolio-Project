class AddPhysicianidColumn < ActiveRecord::Migration[5.2]

  def change
      add_column :patients, :physician_id, :integer
  end
  
end
