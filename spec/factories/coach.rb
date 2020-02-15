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

  def name
    @name ||= "FFaker::Name#{location[:name] || location[:default]}".constantize
  end

  def phone
    @phone ||= "FFaker::PhoneNumber#{location[:phone] || location[:default]}".constantize
  end

  def address
    @address ||= "FFaker::Address#{location[:address] || location[:default]}".constantize
  end

  def postal_code
    address.respond_to?(:postal_code) ? address.postal_code : FFaker::AddressUS.zip_code
  end

  def country
    @country ||= location[:country] || FFaker::Address.country
  end

  def street_address
    if address.respond_to? :street_address
      address.street_address
    elsif address.respond_to? :road_addess
      address.road_addess
    else
      FFaker::Address.street_address
    end
  end

  def secondary_address
    if address.respond_to? :secondary_address
      address.secondary_address
    elsif address.respond_to? :land_address
      address.land_address
    elsif address.respond_to? :secondary_number
      address.secondary_number
    elsif address.respond_to? :appartment_number
      address.appartment_number
    else
      FFaker::Address.secondary_address
    end
  end

  def city
    address.respond_to?(:city) ? address.city : address.municipality
  end

  def province
    if address.respond_to? :state
      address.state
    elsif address.respond_to? :county
      address.county
    elsif address.respond_to? :province
      address.province
    elsif address.respond_to? :region
      address.region
    elsif address.respond_to? :prefecture
      address.prefecture
    else
      FFaker::Address.neighborhood
    end
  end
end

FactoryBot.define do
  factory :coach do
    address_1 { CoachFactoryHelpers.street_address }
    address_2 { CoachFactoryHelpers.secondary_address }
    city { CoachFactoryHelpers.city }
    business_name { FFaker::Company.name }
    business_phone { CoachFactoryHelpers.phone.phone_number }
    country { CoachFactoryHelpers.country }
    email { FFaker::Internet.email }
    full_name { CoachFactoryHelpers.name }
    level_1 { [true, false].sample }
    level_2 { level_1 && [true, false].sample }
    mobile_phone { CoachFactoryHelpers.phone.phone_number }
    postal_code { CoachFactoryHelpers.postal_code }
    procoach_status { [true, false].sample }
    show_in_directory { [true, false].sample }
    source { 'es' }
    specialty { FFaker::Skill.specialty }
    url { FFaker::Internet.http_url }
    url_last_checked { FFaker::Time.between(2.weeks.ago, 1.minute.ago) }
    url_last_status { [true, false].sample }
    user_id { rand(99999) }
    province { CoachFactoryHelpers.province }
  end
end

