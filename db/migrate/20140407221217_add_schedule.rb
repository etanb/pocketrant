class AddSchedule < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.datetime :schedule
      t.integer :hour
      t.references :user

      t.timestamps
    end
  end
end
