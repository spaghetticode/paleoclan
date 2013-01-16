class CreateSlots < ActiveRecord::Migration
  def change
    create_table :slots do |t|
      t.integer :user_id
      t.integer :day_id

      t.timestamps
    end
  end
end
