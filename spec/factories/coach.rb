FactoryBot.define do
  factory :coach do
    sequence(:id)
    address_1 { FFaker::Address.street_address }
    address_2 { FFaker::Address.secondary_address }
    business_name { FFaker::Company.name }
    business_phone { FFaker::PhoneNumber.phone_number }
    city { FFaker::Address.city }
    country { FFaker::Address.country }
    email { FFaker::Internet.email }
    full_name { FFaker::Name.name }
    level_1 { [true, false].sample }
    level_2 { level_1 && [true, false].sample }
    mobile_phone { FFaker::PhoneNumber.short_phone_number }
    postal_code { FFaker::AddressUS.zip_code }
    procoach_status { [true, false].sample }
    province { FFaker::AddressCA.province }
    show_in_directory { [true, false].sample }
    source { 'es' }
    specialty { FFaker::Skill.specialty }
    url { FFaker::Internet.http_url }
    url_last_checked { FFaker::Time.between(2.weeks.ago, 1.minute.ago) }
    url_last_status { [true, false].sample }
    user_id { rand(99999) }
  end
end
