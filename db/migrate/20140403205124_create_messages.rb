class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :text
      t.text :sentiment

      t.timestamps
    end
  end
end
