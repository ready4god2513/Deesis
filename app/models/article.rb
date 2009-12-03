class Article < ActiveRecord::Base
  
  # ASSOCIATIONS
  belongs_to :user
  
  # FILTERS
  before_save :sanitize_user_input
  
  # NAMED SCOPES
  default_scope :order => 'updated_at DESC',
                :limit => 10
  
  
  private
  
    def sanitize_user_input
      self.content = content.to_s.gsub(/&/, "&amp;").gsub(/\"/, "&quot;").gsub(/>/, "&gt;").gsub(/</, "&lt;")
    end
  
end