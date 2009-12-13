xml.instruct!
  xml.user do
    xml.name @user.name_or_username
    xml.profile_pic @user.profile_pic.url
    xml.last_login @user.updated_at
    xml.signed_up @user.created_at
    xml.num_prayers @user.prayer.count
    xml.num_comments @user.comment.count
    xml.num_articles @user.article.count
  end