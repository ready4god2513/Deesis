xml.instruct!
xml.users do
  @users.each do |user|
    xml.user do
      xml.name user.name_or_username
      xml.profile_pic user.profile_pic.url
      xml.last_login user.updated_at
      xml.signed_up user.created_at
      xml.num_prayers 10
      xml.num_comments 10
      xml.num_articles 10
    end
  end
end