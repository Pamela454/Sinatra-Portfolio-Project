class AddMedicalhistoryColumn < ActiveRecord::Migration

  def change
    add_column :patients, :medical_history, :string
  end
  
end
