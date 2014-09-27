FactoryGirl.define do
  factory :article do
    title Faker::Lorem.word
    content Faker::Lorem.paragraph
  end
end
