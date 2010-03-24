class CreateReminders < ActiveRecord::Migration
  def self.up
    create_table :reminders do |t|
      t.integer :user_id
      t.integer :prayer_id

      t.timestamps
    end
  end

  def self.down
    drop_table :reminders
  end
end
