class Reminder < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :prayer
  validates_uniqueness_of :user_id, :scope => :prayer_id
  validates_presence_of :user_id, :prayer_id
  
end