class ChangeIntegerLimitPhysician < ActiveRecord::Migration[5.2]
    def up
        change_column :physicians, :npi, :bigint
      end
    
      def down
        change_column :physicians, :npi, :int
      end
  end