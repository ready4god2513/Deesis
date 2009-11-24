class Article < ActiveRecord::Base
  
  # ASSOCIATIONS
  belongs_to :user
  
  # FILTERS
  before_save :sanitize_user_input
  
  
  private
  
  def sanitize_user_input
    self.content = content.to_s.gsub(/&/, "&amp;").gsub(/\"/, "&quot;").gsub(/>/, "&gt;").gsub(/</, "&lt;")
  end
  
end
