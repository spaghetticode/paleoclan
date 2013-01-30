class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :value
      t.references :day
      t.references :user

      t.timestamps
    end
  end
end
