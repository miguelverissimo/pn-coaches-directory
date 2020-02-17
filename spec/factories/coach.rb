module CoachFactoryHelpers
  extend self

  def location
    @location ||= [
      { country: '', default: '' },
      { country: 'Australia', default: 'AU', name: '' },
      { country: 'Brasil', default: 'BR' },
      { country: 'Canada', default: '', address: 'CA' },
      { country: 'Switzerland', default: 'CH', name: 'FR' },
      { country: 'Denmark', default: 'DA' },
      { country: 'Germany', default: 'DE' },
      { country: 'Finland', default: 'FI', phone: 'SE', name: 'SE' },
      { country: 'France', default: 'FR' },
      { country: 'Greece', default: 'GR', phone: 'IT' },
      { country: 'Indonesia', default: 'ID' },
      { country: 'India', default: 'IN', phone: 'ID' },
      { country: 'Japan', default: 'JA', phone: 'KR' },
      { country: 'Korea', default: 'KR' },
      { country: 'Mexico', default: 'MX' },
      { country: 'The Netherlands', default: 'NL' },
      { country: 'Poland', default: 'PL', phone: 'RU' },
      { country: 'Russia', default: 'RU' },
      { country: 'Sweden', default: 'SE' },
      { country: 'Senegal', default: 'SN' },
      { country: 'Ukraine', default: 'UA' },
      { country: 'United Kingdom', default: '', address: 'UK' },
      { country: 'United States', default: '', address: 'US' }
    ].sample
  end

  def name_class
    @name_class ||= "FFaker::Name#{location[:name] || location[:default]}".constantize
  end

  def name
    name_class.name
  end

  def phone_class
    @phone_class ||= "FFaker::PhoneNumber#{location[:phone] || location[:default]}".constantize
  end

  def phone_number
    phone_class.phone_number
  end

  def address_class
    @address_class ||= "FFaker::Address#{location[:address] || location[:default]}".constantize
  end

  def postal_code
    address_class.respond_to?(:postal_code) ? address_class.postal_code : FFaker::AddressUS.zip_code
  end

  def country
    @country ||= location[:country] || FFaker::Address.country
  end

  def street_address
    if address_class.respond_to? :street_address
      address_class.street_address
    elsif address_class.respond_to? :road_addess
      address_class.road_addess
    else
      FFaker::Address.street_address
    end
  end

  def secondary_address
    if address_class.respond_to? :secondary_address
      address_class.secondary_address
    elsif address_class.respond_to? :land_address
      address_class.land_address
    elsif address_class.respond_to? :secondary_number
      address_class.secondary_number
    elsif address_class.respond_to? :appartment_number
      address_class.appartment_number
    else
      FFaker::Address.secondary_address
    end
  end

  def city
    address_class.respond_to?(:city) ? address_class.city : address_class.municipality
  end

  def province
    if address_class.respond_to? :state
      address_class.state
    elsif address_class.respond_to? :county
      address_class.county
    elsif address_class.respond_to? :province
      address_class.province
    elsif address_class.respond_to? :region
      address_class.region
    elsif address_class.respond_to? :prefecture
      address_class.prefecture
    else
      FFaker::Address.neighborhood
    end
  end
end

FactoryBot.define do
  factory :coach do
    user_id           { rand(9999999) }
    full_name         { CoachFactoryHelpers.name }
    address_1         { CoachFactoryHelpers.street_address }
    address_2         { CoachFactoryHelpers.secondary_address }
    city              { CoachFactoryHelpers.city }
    province          { CoachFactoryHelpers.province }
    postal_code       { CoachFactoryHelpers.postal_code }
    country           { CoachFactoryHelpers.country }
    business_name     { FFaker::Company.name }
    business_phone    { CoachFactoryHelpers.phone_number }
    mobile_phone      { CoachFactoryHelpers.phone_number }
    email             { FFaker::Internet.email }
    specialty         { FFaker::Skill.specialty }
    level_1           { [0, 1].sample }
    level_2           { level_1 == 1 ? [0, 1].sample : 0 }
    procoach_status   { [0, 1].sample }
    show_in_directory { [0, 1].sample }
    url               { FFaker::Internet.http_url }
    url_last_checked  { FFaker::Time.between(2.weeks.ago, 1.minute.ago) }
    url_last_status   { [0, 1].sample }
    source            { 'es' }

    trait :johnny_coach do
      user_id           { 9999999 }
      full_name         { 'Johnny Coach' }
      address_1         { '1 First St.' }
      address_2         { 'Unit 1' }
      city              { 'The Capital' }
      province          { 'Main Province' }
      postal_code       { '1234-567' }
      country           { 'Republic of Johnnystan' }
      business_name     { "Johnny's Fitness" }
      business_phone    { '987 654-3210' }
      mobile_phone      { '987 654-3210' }
      email             { 'johnny@johnnysfitness.com' }
      specialty         { 'Fast body recomposition' }
      level_1           { 1 }
      level_2           { 1 }
      procoach_status   { 1 }
      show_in_directory { 1 }
      url               { 'https://johnnysfitness.com' }
      url_last_checked  { '2020-02-17 11:56:39 -0500' }
      url_last_status   { 1 }
      source            { 'es' }
    end
  end
end

