module HttpAuthConcern
  extend ActiveSupport::Concern
  included do
    before_action :http_authenticate
  end

  def http_authenticate
    return true unless Rails.env == 'production'
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.secrets.http_user && password == Rails.application.secrets.http_pass
    end
  end

end