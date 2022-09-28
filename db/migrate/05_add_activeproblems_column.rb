# frozen_string_literal: true

class AddActiveproblemsColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :patients, :active_problems, :string
  end
end
