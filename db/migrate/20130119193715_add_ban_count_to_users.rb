class AddBanCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ban_count, :integer, :default => 0
  end
end
