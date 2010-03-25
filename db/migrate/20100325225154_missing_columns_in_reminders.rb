class MissingColumnsInReminders < ActiveRecord::Migration
  def self.up
    drop_table :reminders
    create_table :reminders do |t|
      t.int :user_id
      t.int :prayer_id
      t.timestamps
    end
  end

  def self.down
    drop_table :reminders
  end
end
