# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_prayer_session',
  :secret      => '07a83fcd0af2f6f89582f4bb25ba8f78d828af20d59fc86185405afe3a3796fe9c83ad4bab7c15dcd132411a186a2e3cb86e3123093bd85ea5a3851b7f7c0ee9'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
