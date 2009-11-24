xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Deesis"
    xml.description "We Mean Prayer"
    xml.link prayers_url

    for prayer in @prayers
      xml.item do
        xml.title prayer.user.name_or_username
        xml.description prayer.prayer
        xml.pubDate prayer.created_at.to_s(:rfc822)
        xml.link prayer_url(prayer)
      end
    end
  end
end