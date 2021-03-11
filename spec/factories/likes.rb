FactoryBot.define do
  factory :like do
    postId { Faker::Number.within(range: 1..100) }
    user { Faker::name.first_name }
    date { Faker::Time.backward(days: 14, period: :evening) }
  end
end
