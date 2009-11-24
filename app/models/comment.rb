class Comment < ActiveRecord::Base
  
  # ASSOCIATIONS
  belongs_to :user
  belongs_to :prayer
  
  # VALIDATION
  validates_numericality_of :user_id, :prayer_id
  validates_presence_of :comment, :user_id, :prayer_id
  
  # FILTERS
  before_save :sanitize_user_input
  
  # NAMED SCOPES
  default_scope :order => 'created_at DESC'
  
  
  
  private 
  
  def sanitize_user_input
    self.comment = comment.to_s.gsub(/&/, "&amp;").gsub(/\"/, "&quot;").gsub(/>/, "&gt;").gsub(/</, "&lt;")
  end
end