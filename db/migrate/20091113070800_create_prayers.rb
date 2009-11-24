class CreatePrayers < ActiveRecord::Migration
  def self.up
    create_table :prayers do |t|
      t.integer :user_id
      t.text :prayer
      t.integer :num_responses

      t.timestamps
    end
  end

  def self.down
    drop_table :prayers
  end
end
