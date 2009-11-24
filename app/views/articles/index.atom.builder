atom_feed do |feed|
  feed.title("Deesis: Writings of the People")
  feed.updated(@articles.first.updated_at)
 
  for article in @articles
    next if article.updated_at.blank?
    feed.entry(article) do |entry|
      entry.title(article.user.name_or_username)
      entry.content(article.content, :type => 'html')
      entry.updated(article.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ")) # needed to work with Google Reader.
      entry.author do |author|
        author.name(article.user.name_or_username)
      end
    end
  end
end