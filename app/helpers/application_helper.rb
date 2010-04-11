# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def sidebar(sidebar)
    content_for(:sidebar) { sidebar }
  end
  
  def title(title)
    content_for(:title) { title }
  end
  
  def profile_pic(user)
    link_to ('<div class="avatar">' + user.name_or_username + ' </div>', profile_path(user.username))
  end
  
  def format_output(content)
    simple_format auto_link(content)
  end
  
  def user_can_edit(prayer)
    if prayer.user_id != current_user.id
      return false
    else
      return true
    end
  end
  
  def first_x_words(str, n = 10)
     str.split(' ')[0,n].inject{|sum,word| sum + ' ' + word}
  end

end