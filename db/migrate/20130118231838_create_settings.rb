class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :data

      t.timestamps
    end
  end
end
