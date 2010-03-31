class NoActivity < ActiveRecord::Migration
  def self.up
    drop_table :activities
    drop_table :activity_stream_preferences
    drop_table :activity_stream_totals
    drop_table :activity_streams
    drop_table :articles
  end

  def self.down
  end
end
