class Api::V1::CoachDirectoryController < ApplicationController
  def index
    Rails.cache.fetch(cache_key('coach', search_params), expires_in: 1.minute) do
      @coaches = Coach.where(nil)
      search_params.each do |k, v|
        @coaches = @coaches.public_send("filter_by_#{k}", v) if v.present?
      end
      @coaches = @coaches.all
    end
  end

  private

  def search_params
    params.permit(
      :name_starts_with,
      :postal_code,
      :country,
      :city
    )
  end
end
