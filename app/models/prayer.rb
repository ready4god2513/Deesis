class Prayer < ActiveRecord::Base
  # ASSOCIATIONS
  belongs_to :user
  has_many :comment
  
  # VALIDATION
  validates_numericality_of :user_id
  validates_presence_of :prayer, :user_id
  
  # FILTERS
  before_save :sanitize_user_input
  
  # NAMED SCOPES
  default_scope :order => 'created_at DESC',
                :limit => 10
  
  def self.search(search, page, per)
    if per.nil?
      per = 10
    end
    
    paginate :per_page => per, :page => page, 
              :conditions => ['prayer like ? AND answered like ?', "%#{search}%", false]
  end
  
  def self.answered(search, page, per)
    if per.nil?
      per = 10
    end
    
    paginate :per_page => per, :page => page, 
              :conditions => ['prayer like ? AND answered like ?', "%#{search}%", true]
  end
  
  def self.fp
    paginate :per_page => 1, :page => 1
  end
  
  
  
  private 
  
  def sanitize_user_input
    self.prayer = prayer.to_s.gsub(/&/, "&amp;").gsub(/\"/, "&quot;").gsub(/>/, "&gt;").gsub(/</, "&lt;")
  end
  
end