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
end
