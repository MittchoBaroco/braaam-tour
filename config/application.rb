require_relative 'boot'

require "rails"
require 'pry-rails'
# require "devise"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BraaamTour
  class Application < Rails::Application
    config.i18n.load_path += Dir[config.root.join('app/frontend/components/**/*.yml')]
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    # use french as the default locale
    config.i18n.default_locale = :fr
    config.i18n.default_locale = :en if Rails.env.test?
    # config.autoload_paths += %W(#{config.root}/lib)
    # config.autoload_paths += %W(#{config.root}/service)
    # config.autoload_paths += %W(#{config.root}/workflow)
    # config.autoload_paths += %W(#{config.root}/app/service)
    # config.autoload_paths += %W(#{config.root}/app/workflow)

    config.generators do |g|
      g.stylesheets     false
      g.javascripts     false
      g.helper          false
      g.channel         assets: false
    end

    #frontend root
    Rails.application.config.komponent.root = Rails.root.join("app/frontend")

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
