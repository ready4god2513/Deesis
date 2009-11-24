atom_feed do |feed|
  feed.title("Deesis: Building a Community")
  feed.updated(@users.first.updated_at)
 
  for user in @users
    next if user.updated_at.blank?
    feed.entry(user) do |entry|
      entry.title(user.name_or_username)
      entry.content('Joined ' + time_ago_in_words(user.created_at) + ' ago', :type => 'html')
      entry.updated(user.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ")) # needed to work with Google Reader.
      entry.author do |author|
        author.name(user.name_or_username)
      end
    end
  end
end