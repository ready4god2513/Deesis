class Reminder < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :prayer
  validates_uniqueness_of :user_id, :scope => :prayer_id
  validates_presence_of :user_id, :prayer_id
  
  default_scope :order => 'created_at DESC'
  
  def self.find_last_five()
    self.find(:all, :limit => 5)
  end
  
  def self.remove_by_prayer(prayer)
    self.delete_all(:prayer_id => prayer.id)
  end
  
end