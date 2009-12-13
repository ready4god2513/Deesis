xml.instruct!
xml.users do
  @users.each do |user|
    xml.user do
      xml.activity activity.activity
      xml.link activity.link_to
      xml.date activity.created_at
    end
  end
end