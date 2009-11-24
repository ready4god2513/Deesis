# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def profile_pic(user)
    link_to (image_tag user.profile_pic.url), profile_path(user.username)
  end
  
  def profile_pic_with_popup(user)
    link_to (image_tag user.profile_pic.url), user.profile_pic.url(:small)
  end
  
  def format_output(content)
    simple_format auto_link(content)
  end
  
  def user_can_edit(prayer)
    if !current_user || prayer.user_id != current_user.id
      return false
    else
      return true
    end
  end
end