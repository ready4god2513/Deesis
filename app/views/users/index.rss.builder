xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Deesis"
    xml.description "Building A Community"
    xml.link prayers_url

    for user in @users
      xml.item do
        xml.title user.name_or_username
        xml.description 'Joined ' + time_ago_in_words(user.created_at) + ' ago'
        xml.pubDate user.created_at.to_s(:rfc822)
        xml.link profile_path(user.username)
      end
    end
  end
end