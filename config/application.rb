require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GTMGap
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.paperclip_defaults = {
      storage: :s3,
        preserve_files: true,
        s3_region: 'us-east-1',
        s3_credentials: {
          bucket: 'standard.wearegap.com',
          access_key_id: 'AKIAI4FFW7XIGTOVDEHQ',
          secret_access_key: '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'
      }
    }
  end
end
