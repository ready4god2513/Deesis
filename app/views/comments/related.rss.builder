xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Deesis"
    xml.description "We Mean Prayer"
    xml.link prayers_url

    for comment in @comments
      xml.item do
        xml.title comment.user.name_or_username
        xml.description comment.comment
        xml.pubDate comment.created_at.to_s(:rfc822)
        xml.link comment_url(comment)
      end
    end
  end
end