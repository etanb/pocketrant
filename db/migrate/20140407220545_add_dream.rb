class AddDream < ActiveRecord::Migration
  def change
    create_table :dreams do |t|
      t.text :text
      t.text :sentiment
      t.integer :schedule
      t.references :user

      t.timestamps
    end
  end
end
