FactoryBot.define do
  factory :like do
    postId { Faker::Number.within(range: 1..100) }
    user { Faker::Name.first_name }
    date { Faker::Time.backward(days: Faker::Number.within(range: 1..15), period: :evening) }
  end
end
