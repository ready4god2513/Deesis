class User < ActiveRecord::Base
  
  has_many :prayers
  has_many :comments
  has_many :reminders
  
  default_scope :order => 'created_at DESC'
  
  acts_as_authentic do |c|
    c.login_field = "email"
  end
  
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
  
  
  def full_name
    [firstname, lastname].join(' ')
  end
  
  
  def full_name=(name)
    split = name.split(' ', 2)
    self.firstname = split.first
    
    if(split.first == split.last)
      self.lastname = ''
    else
      self.lastname = split.last
    end
  end
  
  
  def wants_to_be_reminded?(prayer)
    self.reminders.find_by_prayer_id(prayer.id)
  end
  

  def self.search(search, page, per)
    if per.nil?
      per = 25
    end
    
    paginate :per_page => per,
              :page => page, 
              :conditions => ['username like ?', "%#{search}%"],
              :order => 'last_request_at DESC'
  end
  
  
  def send_reminder
    UserMailer.deliver_reminder(self)
  end
  
  def deliver_password_reset_instructions!
    reset_perishable_token!
    UserMailer.deliver_password_reset_instructions(self)
  end
  
end