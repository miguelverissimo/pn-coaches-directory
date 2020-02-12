class ApplicationController < ActionController::API

  private

  def cache_key(model, params)
    key = model
    params.each do |k, v|
      key = "#{key}/#{k}:#{v}" if v.present?
    end
    key
  end
end
