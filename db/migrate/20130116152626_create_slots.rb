class CreateSlots < ActiveRecord::Migration
  def change
    create_table :slots do |t|
      t.integer :user_id, :null => false
      t.integer :day_id,  :null => false
      t.timestamps
    end
  end
end
