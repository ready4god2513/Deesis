class UserMailer < ActionMailer::Base
  
  default_url_options[:host] = "deesis.org"
  helper :application
  
  def registration_confirmation(user)
    recipients    user.email
    content_type  "text/html"
    from          "welcome@deesis.org"
    subject       "Welcome to Deesis"
    body          :user => user
  end
  
  def reminder(user)
    from          default_url_options[:host]
    recipients    user.email
    content_type  "text/html"
    subject       "Your Daily Prayer Reminder"
    body          :user => user
  end
  
  
  def prayer_answered(user, prayer)
    from          default_url_options[:host]
    recipients    user.email
    content_type  "text/html"
    subject       "Prayer Answered"
    body          :prayer => prayer
  end
  
  
  def password_reset_instructions(user)
    subject       "Password Reset Instructions"
    from          default_url_options[:host]
    recipients    user.email
    content_type "text/html"
    body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
  end

end