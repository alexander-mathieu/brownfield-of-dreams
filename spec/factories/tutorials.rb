FactoryBot.define do
  factory :tutorial do
    title { Faker::Name.unique.name }
    description { Faker::HitchhikersGuideToTheGalaxy.marvin_quote }
    thumbnail { 'https://i.ytimg.com/vi/CStwQXbTa7c/hqdefault.jpg' }
    playlist_id { Faker::Crypto.md5 }
  end

  factory :classroom_tutorial, parent: :tutorial do
    title { Faker::Name.unique.name }
    description { Faker::HitchhikersGuideToTheGalaxy.marvin_quote }
    thumbnail { 'https://i.ytimg.com/vi/CStwQXbTa7c/hqdefault.jpg' }
    playlist_id { Faker::Crypto.md5 }
    classroom { true }
  end
end
