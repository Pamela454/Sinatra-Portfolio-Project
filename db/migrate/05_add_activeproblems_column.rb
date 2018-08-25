class AddActiveproblemsColumn < ActiveRecord::Migration

  def change
    add_column :patients, :active_problems, :string
  end

end
