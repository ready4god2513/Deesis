class ShouldSendReminder < ActiveRecord::Migration
  def self.up
    add_column :users, :remind_me, :boolean, :default => true
  end

  def self.down
    remove_column :users, :remind_me
  end
end
