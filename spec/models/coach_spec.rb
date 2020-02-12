require 'rails_helper'

RSpec.describe Coach, type: :model do
  context 'default scope' do
    it 'only returns results that are to be displayed in the directory' do
      FactoryBot.create_list(:coach, 8, show_in_directory: true)
      FactoryBot.create_list(:coach, 4, show_in_directory: false)

      expect(Coach.all.count).to eq 8
    end
  end

  context 'dynamic method creation' do
    it 'creates model aliases for table columns' do
      coach = FactoryBot.create(:coach)

      expect(coach).to respond_to(:level_1)
      expect(coach).to respond_to(:level_1=).with(1).argument
      expect(coach).to respond_to(:level_2)
      expect(coach).to respond_to(:level_2=).with(1).argument
      expect(coach).to respond_to(:pro_coach)
      expect(coach).to respond_to(:pro_coach=).with(1).argument
      expect(coach).to respond_to(:show_in_directory)
      expect(coach).to respond_to(:show_in_directory=).with(1).argument
      expect(coach).to respond_to(:url_last_status)
      expect(coach).to respond_to(:url_last_status=).with(1).argument
    end
  end

  context 'data format' do
    context 'address' do
      it 'displays a complete address' do
        coach = FactoryBot.create(
          :coach,
          address_1: 'address 1',
          address_2: 'address 2',
          city: 'city',
          province: 'province',
          postal_code: '123456',
          country: 'country'
        )

        expected = 'address 1, address 2, city, province 123456, country'

        expect(coach.full_address).to eq(expected)
      end

      it 'formats correctly when some address fields are missing' do
        coach = FactoryBot.create(
          :coach,
          address_1: 'address 1',
          address_2: '',
          city: 'city',
          province: 'province',
          postal_code: '123456',
          country: 'country'
        )

        expected = 'address 1, city, province 123456, country'

        expect(coach.full_address).to eq(expected)
      end
    end
  end

  context 'filtering data' do
    before do
      FactoryBot.create_list(:coach, 3, country: 'Republic of Testing', show_in_directory: true)
      FactoryBot.create_list(:coach, 5, city: 'City of Testing', show_in_directory: true)
      FactoryBot.create_list(:coach, 4, postal_code: 'T35T1NG', show_in_directory: true)
      FactoryBot.create(:coach, full_name: 'Ttester Number 1', show_in_directory: true)
      FactoryBot.create(:coach, full_name: 'Ttester Number 2', show_in_directory: true)
      FactoryBot.create(:coach, full_name: 'Ttester Number 3', show_in_directory: true)
      FactoryBot.create(:coach, full_name: 'Ttester Number 4', show_in_directory: true)
    end

    context 'country' do
      it 'filters coaches by country' do
        expect(Coach.filter_by_country('Republic of Testing').count).to eq 3
      end
    end

    context 'city' do
      it 'filters coaches by city' do
        expect(Coach.filter_by_city('City of Testing').count).to eq 5
      end
    end

    context 'postal code' do
      it 'filters coaches by postal code' do
        expect(Coach.filter_by_postal_code('T35T1NG').count).to eq 4
      end
    end

    context 'name starts with' do
      it 'filters coaches with name starting with, independent of case' do
        expect(Coach.filter_by_name_starts_with('tTeSt').count).to eq 4
      end
    end
  end
end
