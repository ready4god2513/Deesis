class Reminder < ActiveRecord::Base
  
  belongs_to :user
  validates_uniqueness_of :user_id, :scope => :prayer_id
  validates_presence_of :user_id, :prayer_id
  
end