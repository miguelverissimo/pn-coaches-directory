class Api::V1::CoachDirectoryController < ApplicationController
  def index
    @coaches = Rails.cache.fetch(cache_key('coach', search_params), expires_in: 5.minutes) do
      filtered_coaches(search_params)
    end
  end

  private

  def filtered_coaches(search_params)
    coaches = Coach.where(nil)
    search_params.each do |k, v|
      coaches = coaches.public_send("filter_by_#{k}", v) if v.present?
    end
    coaches.all
  end

  def search_params
    params.permit(
      :name_starts_with,
      :postal_code,
      :country,
      :city
    )
  end
end
