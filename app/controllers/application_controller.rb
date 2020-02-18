class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate_request!

  private

  def cache_key(model, params)
    key = model
    params.each do |k, v|
      key = "#{key}/#{k}:#{v}" if v.present?
    end
    key
  end

  def authenticate_request!
    return true if authenticate_with_token

    render json: { errors: [{ detail: 'Access denied' }] }, status: :unauthorized
  end

  def authenticate_with_token
    authenticate_with_http_token do |token, _opts|
      client = WhitelistedClient.find_by(token: token)
      client&.update(
        last_accessed_on: Time.now,
        last_accessed_by: request.env['REMOTE_ADDR']
      )
      client
    end
  end
end
