class Answered < ActiveRecord::Migration
  def self.up
    add_column :prayers, :answered, :boolean, :default => false
  end

  def self.down
    remove_column :prayers, :answered
  end
end
