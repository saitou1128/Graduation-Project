require_relative "boot"

require "rails"

require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "active_storage/engine"
require "action_cable/engine"

Bundler.require(*Rails.groups)

module Myapp
  class Application < Rails::Application
    config.load_defaults 7.2
    config.paths["app/assets"] << Rails.root.join("app/assets/builds")
  end
end