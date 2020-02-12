class Api::V1::CoachDirectoryController < ApplicationController
  def index
    @coaches = Coach.where(nil)
    search_params.each do |k, v|
      @coaches = @coaches.public_send("filter_by_#{k}", v) if v.present?
    end

    # render json: @coaches, status: :ok
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
