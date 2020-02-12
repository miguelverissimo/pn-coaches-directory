require 'rails_helper'

RSpec.describe Api::V1::CoachDirectoryController, type: :controller do
  before do
    FactoryBot.create_list(:coach, 10, show_in_directory: false)
    FactoryBot.create_list(:coach, 10, show_in_directory: true)
    FactoryBot.create(:coach, full_name: 'Ttester Number 1', show_in_directory: true)
    FactoryBot.create(:coach, full_name: 'Ttester Number 2', show_in_directory: true)
    FactoryBot.create(:coach, full_name: 'Ttester Number 3', show_in_directory: true)
    FactoryBot.create_list(:coach, 5, country: 'Republic of Testing', show_in_directory: true)
    FactoryBot.create_list(:coach, 5, city: 'City of Testing', show_in_directory: true)
    FactoryBot.create_list(:coach, 2, postal_code: 'T35T1NG', show_in_directory: true)
    FactoryBot.create_list(:coach, 2,
                           country: 'Republic of Testing',
                           city: 'City of Testing',
                           show_in_directory: true)
    FactoryBot.create_list(:coach, 2,
                           country: 'Republic of Testing',
                           city: 'City of Testing',
                           postal_code: 'T35T1NG',
                           show_in_directory: true)
    FactoryBot.create(:coach,
                      full_name: 'Ttester Number 4',
                      country: 'Republic of Testing',
                      city: 'City of Testing',
                      postal_code: 'T35T1NG',
                      show_in_directory: true)

    request.content_type = 'application/json'
  end

  describe '#index' do
    def make_request(params = {})
      get :index, params: params.merge(format: :json)
    end

    context 'filtering coaches' do
      context 'when the request does not have any filters' do
        before do
          make_request
        end

        it 'returns 200 status code' do
          make_request
          expect(response.status).to eq 200
        end

        it 'returns serialized coach data' do
          expect(json_response.first.keys.uniq)
            .to include(
              'name',
              'level_1',
              'level_2',
              'certification_level',
              'business_name',
              'location',
              'business_phone',
              'mobile_phone',
              'email',
              'url'
          )
        end

        it 'returns all the listed coaches' do
          expect(json_response.count).to eq 30
        end
      end

      context 'when the request has country filter' do
        before do
          make_request country: 'Republic of Testing'
        end

        it 'returns all the listed coaches for a given country' do
          expect(json_response.count).to eq 10
        end
      end

      context 'when the request has city filter' do
        before do
          make_request(city: 'City of Testing')
        end

        it 'returns all the listed coaches for a given city' do
          expect(json_response.count).to eq 10
        end
      end

      context 'when the request has both country and city filters' do
        before do
          make_request(country: 'Republic of Testing', city: 'City of Testing')
        end

        it 'returns all the listed coaches for a given city in a given country' do
          expect(json_response.count).to eq 5
        end
      end

      context 'when the request has postal code filter' do
        before do
          make_request(postal_code: 'T35T1NG')
        end

        it 'returns all the listed coaches for a given postal code' do
          expect(json_response.count).to eq 5
        end
      end

      context 'when the request has country, city and postal code filters' do
        before do
          make_request(country: 'Republic of Testing', city: 'City of Testing', postal_code: 'T35T1NG')
        end

        it 'returns all the listed coaches for a given city in a given country with a given postal code' do
          expect(json_response.count).to eq 3
        end
      end

      context 'when the request has name starts with filter' do
        before do
          make_request(name_starts_with: 'Ttester')
        end

        it 'returns all the listed coaches for a given city' do
          expect(json_response.count).to eq 4
        end
      end

      context 'when the request has name starts with, country, city and postal code filters' do
        before do
          make_request(name_starts_with: 'Ttester', country: 'Republic of Testing', city: 'City of Testing', postal_code: 'T35T1NG')
        end

        it 'returns all the listed coaches for a given city in a given country with a given postal code' do
          expect(json_response.count).to eq 1
        end
      end
    end

    context 'caching of data' do
      around { |example| with_caching { example.run } }
      before { Rails.cache.clear }

      it 'caches the data for 5 minutes' do
        Coach.should_receive(:where).once.and_return([])
        make_request
        make_request
      end

      xit 'caches different queries into independent keys' do

      end
    end
  end

  def json_response
    JSON.parse(response.body)
  end

  def with_caching(on = true)
    caching = ActionController::Base.perform_caching
    ActionController::Base.perform_caching = on
    yield
  ensure
    ActionController::Base.perform_caching = caching
  end

  def without_caching(&block)
    with_caching(false, &block)
  end
end

