class User < ActiveRecord::Base
  default_scope :order => 'created_at DESC'
  named_scope :community, :conditions => { :status => true }, 
                          :order => 'created_at DESC'
                        


  acts_as_authentic
  has_attached_file :profile_pic,
                    :styles => {
                      :thumb => "48x48#",
                      :small  => "400x400>" 
                    },
                    :default_style => :thumb,
                    :default_url => '/images/missing.png'


  def name_or_username
    if firstname.nil? || firstname.empty?
      username
    else
      firstname + ' ' + lastname
    end
  end

  def self.search(search, page, per)
    if per.nil?
      per = 10
    end
    
    paginate :per_page => per,
              :page => page, 
              :conditions => ['username like ?', "%#{search}%"],
              :order => 'created_at DESC'
  end
  
end