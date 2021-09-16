module HttpAuthConcern  
  extend ActiveSupport::Concern
  included do
      before_action :http_authenticate
  end
  def http_authenticate
      return true unless Rails.env == 'production'
      authenticate_or_request_with_http_basic do |username, password|
          username == 'HTTP_AUTHENTICATION_USERNAME' && password == 'HTTP_AUTHENTICATION_PASSWORD'
      end
  end
end