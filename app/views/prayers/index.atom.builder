atom_feed do |feed|
  feed.title("Deesis: We Mean Prayer")
  feed.updated(@prayers.first.updated_at)
 
  for prayer in @prayers
    next if prayer.updated_at.blank?
    feed.entry(prayer) do |entry|
      entry.title(prayer.user.name_or_username)
      entry.content(prayer.prayer, :type => 'html')
      entry.updated(prayer.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ")) # needed to work with Google Reader.
      entry.author do |author|
        author.name(prayer.user.name_or_username)
      end
    end
  end
end