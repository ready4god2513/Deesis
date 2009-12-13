xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Deesis"
    xml.description "Building A Community"
    xml.link prayers_url

    for activity in @activities
      xml.item do
        xml.title activity.activity
        xml.description activity.activity
        xml.pubDate activity.created_at.to_s(:rfc822)
        xml.link activity.link_to
      end
    end
  end
end