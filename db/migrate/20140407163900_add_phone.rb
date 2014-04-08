class AddPhone < ActiveRecord::Migration
  def change
    add_column :users, :phone, :integer, :limit => 8
  end
end
