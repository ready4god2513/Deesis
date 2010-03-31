class PrivatePrayers < ActiveRecord::Migration
  def self.up
    add_column :prayers, :private, :boolean, :default => false
  end

  def self.down
    remove_column :prayers, :private
  end
end
