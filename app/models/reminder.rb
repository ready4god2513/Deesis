class Reminder < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :prayer
  
  validates_presence_of :user_id, :prayer_id
  validates_numericality_of :user_id, :prayer_id
  validates_uniqueness_of :reminder_id, :scope => [:user_id, :prayer_id]
end