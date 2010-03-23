class UserMailer < ActionMailer::Base
  
  def registration_confirmation(user)
    recipients  user.email
    from        "welcome@deesis.org"
    subject     "Welcome to Deesis"
    body        :user => user
  end
  
  def reminder(user)
    recipients  user.email
    from        "reminder@deesis.org"
    subject     "Your Daily Prayer Reminder"
    body        :user => user
  end

end