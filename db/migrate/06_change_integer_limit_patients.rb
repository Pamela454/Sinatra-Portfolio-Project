class ChangeIntegerLimitPatients < ActiveRecord::Migration[5.2]

  def up
    change_column :patients, :physician_id, :bigint
    change_column :patients, :id, :bigint
  end

  def down
    change_column :patients, :physician_id, :int
    change_column :patients, :id, :int
  end
end
