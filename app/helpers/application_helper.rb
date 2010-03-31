# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def sidebar(sidebar)
    content_for(:sidebar) { sidebar }
  end
  
  def profile_pic(user, size = :thumb)
    link_to (image_tag user.profile_pic.url(size)), profile_path(user.username)
  end
  
  def profile_pic_with_popup(user)
    link_to (image_tag user.profile_pic.url), user.profile_pic.url(:small), :class => 'expand_avatar'
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
  
  def first_x_words(str, n = 10)
     str.split(' ')[0,n].inject{|sum,word| sum + ' ' + word}
  end

end