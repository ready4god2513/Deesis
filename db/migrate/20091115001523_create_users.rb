class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :location
      t.integer :postal_code
      t.string :email
      t.string :username
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.string :api_key
      t.string :pic
      t.integer :login_count
      t.datetime :last_login_at
      t.datetime :last_request_at
      t.boolean :status

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
