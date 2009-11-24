xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Deesis"
    xml.description "Writings of the People"
    xml.link prayers_url

    for article in @articles
      xml.item do
        xml.title article.user.name_or_username
        xml.description article.content
        xml.pubDate article.created_at.to_s(:rfc822)
        xml.link article_url(article)
      end
    end
  end
end