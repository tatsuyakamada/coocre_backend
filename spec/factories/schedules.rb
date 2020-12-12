FactoryBot.define do
  factory :schedule do
    date { Time.zone.today }
    category { 'dinner' }
    memo { Faker::Lorem.sentence }
  end
end
