FactoryBot.define do
  factory :whitelisted_client do
    name       { FFaker::Company.name }
    domain     { FFaker::Internet.http_url }
    token      { SecureRandom.urlsafe_base64(nil, false) }
    granted_on { Time.now }
    granted_by { 'Factory' }
    notes      { 'Test fixture' }
  end
end
