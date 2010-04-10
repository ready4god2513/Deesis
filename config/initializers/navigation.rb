RPH::Navigation::Builder.config do |navigation|
  
  navigation.define :public do |menu|
    menu.item PrayersController, :path => :root_path
    menu.item RemindersController, :path => :reminders_path, :text => 'Reminders'
    menu.item UsersController, :path => :account_path, :text => 'Profile'
  end
 
end