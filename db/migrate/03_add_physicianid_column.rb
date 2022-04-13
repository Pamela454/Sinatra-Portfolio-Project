class AddPhysicianidColumn < ActiveRecord::Migration

  def change
      add_column :patients, :physician_id, :integer
  end
  
end
