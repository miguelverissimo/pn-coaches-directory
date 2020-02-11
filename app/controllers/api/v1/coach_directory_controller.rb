class Api::V1::CoachDirectoryController < ApplicationController
  def index
    @coaches = Coach.last(10)
  end

  private

  def search_params
    params.permit(
      :name,
      :postal_code,
      :country,
      :city
    )
  end
end
