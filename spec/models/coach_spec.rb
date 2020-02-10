require 'rails_helper'

RSpec.describe Coach, type: :model do
  it 'only returns results that are to be displayed in the directory' do
    FactoryBot.create_list(:coach, 8, show_in_directory: true)
    FactoryBot.create_list(:coach, 4, show_in_directory: false)

    expect(Coach.all.count).to eq 8
  end

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
