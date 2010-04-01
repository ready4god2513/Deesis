# Be sure to restart your server when you modify this file

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), "boot")

ENV["RECAPTCHA_PUBLIC_KEY"]  = "6LcSwAQAAAAAACIgLmZlhgKzGicx0_Z2P6o536c1"
ENV["RECAPTCHA_PRIVATE_KEY"] = "6LcSwAQAAAAAAFduT4tzR7cNoyThPFAgEZFE5A1n"


Rails::Initializer.run do |config|
  config.gem "authlogic"
  config.gem "will_paginate"
  config.gem "searchlogic"
  config.gem "ambethia-recaptcha", :lib => "recaptcha/rails", :source => "http://gems.github.com"
  config.gem "whenever", :lib => false, :source => "http://gemcutter.org/"
  config.time_zone = "UTC"
end