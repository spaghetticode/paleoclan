class CreateCredits < ActiveRecord::Migration
  def change
    create_table :credits do |t|
      t.belongs_to :user
      t.boolean :used, :default => false
      t.timestamps
    end
    add_index :credits, :user_id
  end
end
