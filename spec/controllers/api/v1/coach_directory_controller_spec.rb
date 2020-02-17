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
    before { Rails.cache.clear }

    def make_request(params = {})
      get :index, params: params.merge(format: :json)
    end

    context 'json response' do
      it 'formats the response as defined by the specs' do
        FactoryBot.create(:coach, :johnny_coach)
        expected = '[{"name":"Johnny Coach","certification_level":"Level 2",' \
          '"business_name":"Johnny\'s Fitness","business_phone":"987 654-3210",' \
          '"mobile_phone":"987 654-3210","email":"johnny@johnnysfitness.com",' \
          '"level_1":true,"level_2":true,"url":"https://johnnysfitness.com",' \
          '"tag_line":"Fast body recomposition","location":"1 First St., Unit 1, ' \
          'The Capital, Main Province 1234-567, Republic of Johnnystan"}]'

        make_request(country: 'Republic of Johnnystan')
        expect(response.body).to eq(expected)
      end
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

      it 'caches the data for 5 minutes' do
        allow(subject).to receive(:filtered_coaches)
        make_request(country: 'Republic of Testing')
        make_request(country: 'Republic of Testing')
        make_request(country: 'Republic of Testing')
        make_request(country: 'Republic of Testing')
        expect(subject).to have_received(:filtered_coaches).once
      end

      it 'caches different queries into independent keys' do
        allow(subject).to receive(:filtered_coaches)
        make_request(country: 'Republic of Testing')
        make_request(country: 'Other Country')
        make_request(country: 'Republic of Testing')
        make_request(country: 'Other Country')
        expect(subject).to have_received(:filtered_coaches).twice
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

